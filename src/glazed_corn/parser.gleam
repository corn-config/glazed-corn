import glazed_corn
import glazed_corn/lexer.{type Token}
import gleam/dict.{type Dict}
import gleam/list
import gleam/result

pub type Root {
  Root(inputs: Dict(String, Entry), object: Dict(String, Entry))
}

pub type Entry {
  String(String)
  Integer(Int)
  Float(Float)
  Boolean(Bool)
  Object(pairs: Dict(String, Entry))
  Array(List(EntryOrSpread))
  Null
  Input(String)
}

pub type EntryOrSpread {
  Entry(Entry)
  Spread(String)
}

pub fn parse_tokens(tokens: List(Token)) -> Result(Root, glazed_corn.ParseError) {
  case tokens {
    [lexer.Let, lexer.OpenBrace, ..rest] -> {
      use #(inputs, rest) <- result.try(parse_inputs(rest, dict.new()))
      use #(object, rest) <- result.try(do_parse_object(rest, dict.new()))

      case rest |> list.is_empty {
        True -> Ok(Root(inputs:, object:))
        False -> Error(glazed_corn.InvalidFormat)
      }
    }
    [lexer.OpenBrace, ..rest] -> {
      use #(object, rest) <- result.try(do_parse_object(rest, dict.new()))

      case rest |> list.is_empty {
        True -> Ok(Root(inputs: dict.new(), object:))
        False -> Error(glazed_corn.InvalidFormat)
      }
    }

    _ -> Error(glazed_corn.InvalidFormat)
  }
}

fn parse_inputs(
  tokens: List(Token),
  inputs: Dict(String, Entry),
) -> Result(#(Dict(String, Entry), List(Token)), glazed_corn.ParseError) {
  case tokens {
    [lexer.CloseBrace, lexer.In, lexer.OpenBrace, ..rest] ->
      #(inputs, rest) |> Ok
    [lexer.InputName(key), lexer.Equals, ..rest] -> {
      use #(value, rest) <- result.try(rest |> parse_entry)

      parse_inputs(rest, inputs |> dict.insert(key, value))
    }
    [lexer.Comment(_), ..rest] -> parse_inputs(rest, inputs)
    [] -> Error(glazed_corn.UnexpectedEof)
    [token, ..] ->
      Error(glazed_corn.UnexpectedToken(lexer.token_to_string(token)))
  }
}

fn parse_entry(
  tokens: List(Token),
) -> Result(#(Entry, List(Token)), glazed_corn.ParseError) {
  case tokens {
    [lexer.Literal(lit), ..rest] -> #(String(lit), rest) |> Ok
    [lexer.Integer(int), ..rest] -> #(Integer(int), rest) |> Ok
    [lexer.Float(float), ..rest] -> #(Float(float), rest) |> Ok
    [lexer.Boolean(bool), ..rest] -> #(Boolean(bool), rest) |> Ok
    [lexer.OpenBrace, ..rest] -> rest |> parse_object
    [lexer.OpenBracket, ..rest] -> rest |> parse_array
    [lexer.Null, ..rest] -> #(Null, rest) |> Ok
    [lexer.InputName(input), ..rest] -> #(Input(input), rest) |> Ok
    [lexer.Comment(_), ..rest] -> parse_entry(rest)
    [] -> Error(glazed_corn.UnexpectedEof)
    [token, ..] ->
      Error(glazed_corn.UnexpectedToken(lexer.token_to_string(token)))
  }
}

fn parse_object(
  tokens: List(Token),
) -> Result(#(Entry, List(Token)), glazed_corn.ParseError) {
  case do_parse_object(tokens, dict.new()) {
    Ok(#(object, rest)) -> #(object |> Object, rest) |> Ok
    Error(err) -> Error(err)
  }
}

fn do_parse_object(
  tokens: List(Token),
  object: Dict(String, Entry),
) -> Result(#(Dict(String, Entry), List(Token)), glazed_corn.ParseError) {
  case tokens {
    [lexer.CloseBrace, ..rest] -> #(object, rest) |> Ok
    [lexer.Key(key), lexer.Equals, ..rest] -> {
      use #(value, rest) <- result.try(rest |> parse_entry)

      do_parse_object(rest, object |> dict.insert(key, value))
    }
    [lexer.Comment(_), ..rest] -> do_parse_object(rest, object)
    [] -> Error(glazed_corn.UnexpectedEof)
    [token, ..] ->
      Error(glazed_corn.UnexpectedToken(lexer.token_to_string(token)))
  }
}

fn parse_array(
  tokens: List(Token),
) -> Result(#(Entry, List(Token)), glazed_corn.ParseError) {
  case do_parse_array(tokens, []) {
    Ok(#(array, rest)) -> #(array |> list.reverse |> Array, rest) |> Ok
    Error(err) -> Error(err)
  }
}

fn do_parse_array(
  tokens: List(Token),
  array: List(EntryOrSpread),
) -> Result(#(List(EntryOrSpread), List(Token)), glazed_corn.ParseError) {
  case tokens {
    [lexer.CloseBracket, ..rest] -> #(array, rest) |> Ok
    [lexer.Spread, lexer.InputName(input), ..rest] ->
      do_parse_array(rest, [Spread(input), ..array])
    _ -> {
      use #(value, rest) <- result.try(tokens |> parse_entry)

      do_parse_array(rest, [Entry(value), ..array])
    }
  }
}
