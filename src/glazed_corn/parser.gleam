import glazed_corn
import glazed_corn/token.{type Token}
import gleam/dict.{type Dict}
import gleam/list
import gleam/result

pub type Root {
  Root(inputs: Dict(String, Entry), object: List(PairOrSpread))
}

pub type Entry {
  String(String)
  Integer(Int)
  Float(Float)
  Boolean(Bool)
  Object(pairs: List(PairOrSpread))
  Array(List(EntryOrSpread))
  Null
  Input(String)
}

pub type EntryOrSpread {
  ArrayEntry(Entry)
  ArraySpread(String)
}

pub type PairOrSpread {
  Pair(List(String), Entry)
  ObjectSpread(String)
}

pub fn parse_tokens(tokens: List(Token)) -> Result(Root, glazed_corn.ParseError) {
  case tokens {
    [token.Let, token.OpenBrace, ..rest] -> {
      use #(inputs, rest) <- result.try(parse_inputs(rest, dict.new()))
      use #(object, rest) <- result.try(do_parse_object(rest, []))

      case rest |> list.is_empty {
        True -> Ok(Root(inputs:, object:))
        False -> Error(glazed_corn.InvalidFormat)
      }
    }
    [token.OpenBrace, ..rest] -> {
      use #(object, rest) <- result.try(do_parse_object(rest, []))

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
    [token.CloseBrace, token.In, token.OpenBrace, ..rest] ->
      #(inputs, rest) |> Ok
    [token.InputName(key), token.Equals, ..rest] -> {
      use #(value, rest) <- result.try(rest |> parse_entry)

      parse_inputs(rest, inputs |> dict.insert(key, value))
    }
    [token.Comment(_), ..rest] -> parse_inputs(rest, inputs)
    [] -> Error(glazed_corn.UnexpectedEof)
    [token, ..] -> Error(glazed_corn.UnexpectedToken(token.to_string(token)))
  }
}

fn parse_entry(
  tokens: List(Token),
) -> Result(#(Entry, List(Token)), glazed_corn.ParseError) {
  case tokens {
    [token.Literal(lit), ..rest] -> #(String(lit), rest) |> Ok
    [token.Integer(int), ..rest] -> #(Integer(int), rest) |> Ok
    [token.Float(float), ..rest] -> #(Float(float), rest) |> Ok
    [token.Boolean(bool), ..rest] -> #(Boolean(bool), rest) |> Ok
    [token.OpenBrace, ..rest] -> rest |> parse_object
    [token.OpenBracket, ..rest] -> rest |> parse_array
    [token.Null, ..rest] -> #(Null, rest) |> Ok
    [token.InputName(input), ..rest] -> #(Input(input), rest) |> Ok
    [token.Comment(_), ..rest] -> parse_entry(rest)
    [] -> Error(glazed_corn.UnexpectedEof)
    [token, ..] -> Error(glazed_corn.UnexpectedToken(token.to_string(token)))
  }
}

fn parse_object(
  tokens: List(Token),
) -> Result(#(Entry, List(Token)), glazed_corn.ParseError) {
  case do_parse_object(tokens, []) {
    Ok(#(object, rest)) -> #(object |> list.reverse |> Object, rest) |> Ok
    Error(err) -> Error(err)
  }
}

fn do_parse_object(
  tokens: List(Token),
  object: List(PairOrSpread),
) -> Result(#(List(PairOrSpread), List(Token)), glazed_corn.ParseError) {
  case tokens {
    [token.CloseBrace, ..rest] -> #(object, rest) |> Ok
    [token.Key(key), ..rest] -> {
      use #(key_chain, rest) <- result.try(rest |> parse_key_chain([key]))
      use #(value, rest) <- result.try(rest |> parse_entry)

      do_parse_object(rest, [Pair(key_chain, value), ..object])
    }
    [token.Spread, token.InputName(input), ..rest] ->
      do_parse_object(rest, [ObjectSpread(input), ..object])
    [token.Comment(_), ..rest] -> do_parse_object(rest, object)
    [] -> Error(glazed_corn.UnexpectedEof)
    [token, ..] -> Error(glazed_corn.UnexpectedToken(token.to_string(token)))
  }
}

fn parse_key_chain(
  tokens: List(Token),
  keys: List(String),
) -> Result(#(List(String), List(Token)), glazed_corn.ParseError) {
  case tokens {
    [token.Equals, ..rest] -> #(keys |> list.reverse, rest) |> Ok
    [token.Chain, token.Key(key), ..rest] ->
      parse_key_chain(rest, [key, ..keys])
    [token.Comment(_), ..rest] -> parse_key_chain(rest, keys)
    [] -> Error(glazed_corn.UnexpectedEof)
    [token, ..] -> Error(glazed_corn.UnexpectedToken(token.to_string(token)))
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
    [token.CloseBracket, ..rest] -> #(array, rest) |> Ok
    [token.Spread, token.InputName(input), ..rest] ->
      do_parse_array(rest, [ArraySpread(input), ..array])
    _ -> {
      use #(value, rest) <- result.try(tokens |> parse_entry)

      do_parse_array(rest, [ArrayEntry(value), ..array])
    }
  }
}
