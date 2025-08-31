import envoy
import glazed_corn/error
import glazed_corn/parser.{
  type Entry, type EntryOrSpread, type PairOrSpread, type Root, ArrayEntry,
  ArraySpread,
}
import glazed_corn/token
import glazed_corn/value.{type Value}
import gleam/dict.{type Dict}
import gleam/list
import gleam/result

pub fn evaluate(root: Root) -> Result(Value, error.ParseError) {
  do_evaluate(parser.Object(root.object), root.inputs)
}

fn do_evaluate(
  entry: Entry,
  inputs: Dict(String, Entry),
) -> Result(Value, error.ParseError) {
  case entry {
    parser.Array(entries) -> entries |> evaluate_array(inputs)
    parser.Boolean(bool) -> Ok(value.Boolean(bool))
    parser.Float(float) -> Ok(value.Float(float))
    parser.Input(input) -> {
      use entry <- result.try(inputs |> get_input(input))
      entry |> do_evaluate(inputs)
    }
    parser.Integer(integer) -> Ok(value.Integer(integer))
    parser.Null -> Ok(value.Null)
    parser.Object(pairs:) -> pairs |> evaluate_object(inputs)
    parser.String(parts) -> parts |> evaluate_string(inputs)
  }
}

fn evaluate_string(
  parts: List(token.StringPart),
  inputs: Dict(String, Entry),
) -> Result(Value, error.ParseError) {
  case do_evaluate_string(parts, inputs, "") {
    Ok(string) -> Ok(value.String(string))
    Error(err) -> Error(err)
  }
}

fn do_evaluate_string(
  parts: List(token.StringPart),
  inputs: Dict(String, Entry),
  acc: String,
) -> Result(String, error.ParseError) {
  case parts {
    [] -> Ok(acc)
    [first, ..rest] -> {
      case first {
        token.InputPart(input) -> {
          use entry <- result.try(inputs |> get_input(input))

          case entry |> do_evaluate(inputs) {
            Ok(value.String(string)) ->
              do_evaluate_string(rest, inputs, acc <> string)
            Ok(_) -> Error(error.InvalidFormat)
            Error(err) -> Error(err)
          }
        }
        token.LiteralPart(part) -> {
          do_evaluate_string(rest, inputs, acc <> part)
        }
      }
    }
  }
}

fn evaluate_array(
  entries: List(EntryOrSpread),
  inputs: Dict(String, Entry),
) -> Result(Value, error.ParseError) {
  case do_evaluate_array(entries, inputs, []) {
    Ok(array) -> Ok(value.Array(array |> list.reverse))
    Error(err) -> Error(err)
  }
}

fn do_evaluate_array(
  pairs: List(EntryOrSpread),
  inputs: Dict(String, Entry),
  acc: List(Value),
) -> Result(List(Value), error.ParseError) {
  case pairs {
    [] -> Ok(acc)
    [first, ..rest] -> {
      case first {
        ArraySpread(spread) -> {
          use entry <- result.try(inputs |> get_input(spread))

          case entry |> do_evaluate(inputs) {
            Ok(value.Array(array)) ->
              do_evaluate_array(
                rest,
                inputs,
                array
                  |> list.reverse
                  |> list.append(acc),
              )
            Ok(_) -> Error(error.InvalidSpread)
            Error(err) -> Error(err)
          }
        }
        ArrayEntry(entry) -> {
          use value <- result.try(do_evaluate(entry, inputs))

          do_evaluate_array(rest, inputs, [value, ..acc])
        }
      }
    }
  }
}

fn evaluate_object(
  pairs: List(PairOrSpread),
  inputs: Dict(String, Entry),
) -> Result(Value, error.ParseError) {
  case do_evaluate_object(pairs, inputs, dict.new()) {
    Ok(object) -> Ok(value.Object(object))
    Error(err) -> Error(err)
  }
}

fn do_evaluate_object(
  pairs: List(PairOrSpread),
  inputs: Dict(String, Entry),
  acc: Dict(String, Value),
) -> Result(Dict(String, Value), error.ParseError) {
  case pairs {
    [] -> Ok(acc)
    [first, ..rest] -> {
      case first {
        parser.ObjectSpread(spread) -> {
          use entry <- result.try(inputs |> get_input(spread))

          case entry |> do_evaluate(inputs) {
            Ok(value.Object(object)) ->
              do_evaluate_object(rest, inputs, acc |> dict.merge(object))
            Ok(_) -> Error(error.InvalidSpread)
            Error(err) -> Error(err)
          }
        }
        parser.Pair(path, entry) -> {
          use value <- result.try(do_evaluate(entry, inputs))
          use object <- result.try(acc |> insert_at_path(path, value))

          do_evaluate_object(rest, inputs, object)
        }
      }
    }
  }
}

fn insert_at_path(
  object: Dict(String, Value),
  path: List(String),
  value: Value,
) -> Result(Dict(String, Value), error.ParseError) {
  case path {
    [key] -> {
      object |> dict.insert(key, value) |> Ok
    }
    [first, ..rest] -> {
      let entry =
        object
        |> dict.get(first)
        |> result.lazy_unwrap(fn() { value.Object(dict.new()) })

      case entry {
        value.Object(nested_object) -> {
          use nested_object <- result.try(
            nested_object |> insert_at_path(rest, value),
          )
          object |> dict.insert(first, value.Object(nested_object)) |> Ok
        }
        _ -> Error(error.InvalidChain)
      }
    }
    [] -> Ok(dict.new())
  }
}

fn get_input(
  inputs: Dict(String, Entry),
  input: String,
) -> Result(Entry, error.ParseError) {
  case input {
    "env_" <> env -> {
      case envoy.get(env) {
        Error(_) -> {
          case inputs |> dict.get(input) {
            Ok(entry) -> Ok(entry)
            Error(_) -> Error(error.MissingInput(input))
          }
        }
        Ok(env) -> Ok(parser.String([token.LiteralPart(env)]))
      }
    }
    _ -> {
      case inputs |> dict.get(input) {
        Ok(entry) -> Ok(entry)
        Error(_) -> Error(error.MissingInput(input))
      }
    }
  }
}
