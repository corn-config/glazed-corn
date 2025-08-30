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
  Array(List(Entry))
  Null
  Input(String)
}

pub type EntryOrSpread {
  Entry(Entry)
  Spread(String)
}

pub fn parse_entry(
  tokens: List(Token),
) -> Result(#(Entry, List(Token)), glazed_corn.ParseError) {
  case tokens {
    [lexer.Literal(lit), ..rest] -> #(String(lit), rest) |> Ok
    [lexer.Integer(int), ..rest] -> #(Integer(int), rest) |> Ok
    [lexer.Float(float), ..rest] -> #(Float(float), rest) |> Ok
    [lexer.Boolean(bool), ..rest] -> #(Boolean(bool), rest) |> Ok
    [lexer.OpenBrace, ..rest] -> parse_object(rest, dict.new())
    [lexer.OpenBracket, ..rest] -> parse_array(rest)
    [lexer.Null, ..rest] -> #(Null, rest) |> Ok
    [] -> Error(glazed_corn.UnexpectedEof)
    [token, ..] ->
      Error(glazed_corn.UnexpectedToken(lexer.token_to_string(token)))
  }
}

fn parse_object(
  tokens: List(Token),
  object: Dict(String, Entry),
) -> Result(#(Entry, List(Token)), glazed_corn.ParseError) {
  case tokens {
    [lexer.CloseBrace, ..rest] -> #(Object(object), rest) |> Ok
    [lexer.Key(key), lexer.Equals, ..rest] -> {
      use #(value, rest) <- result.try(rest |> parse_entry)

      parse_object(rest, object |> dict.insert(key, value))
    }
    _ -> todo
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
  array: List(Entry),
) -> Result(#(List(Entry), List(Token)), glazed_corn.ParseError) {
  case tokens {
    [lexer.CloseBracket, ..rest] -> #(array, rest) |> Ok

    _ -> {
      use #(value, rest) <- result.try(tokens |> parse_entry)

      do_parse_array(rest, [value, ..array])
    }
  }
}
