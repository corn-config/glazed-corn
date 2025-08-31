import envoy
import glazed_corn/error
import glazed_corn/parser.{
  type Entry, type EntryOrSpread, type PairOrSpread, type Root, ArrayEntry,
  ArraySpread,
}
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
    parser.String(string) -> Ok(value.String(string))
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
        Ok(env) -> Ok(parser.String(env))
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

fn evaluate_array(
  entries: List(EntryOrSpread),
  inputs: Dict(String, Entry),
) -> Result(Value, error.ParseError) {
  case do_evaluate_array(entries, inputs, []) {
    Ok(array) -> Ok(value.Array(array))
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
              do_evaluate_array(rest, inputs, array |> list.append(array))
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
        parser.Pair(_key, entry) -> {
          // FIXME: do key chaining
          use value <- result.try(do_evaluate(entry, inputs))

          do_evaluate_object(rest, inputs, acc |> dict.insert("key", value))
        }
      }
    }
  }
}
