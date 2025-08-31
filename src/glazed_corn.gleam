import glazed_corn/error
import glazed_corn/evaluator
import glazed_corn/lexer
import glazed_corn/parser
import glazed_corn/value.{type Value}
import gleam/bit_array
import gleam/result

pub fn parse(source: String) -> Result(Value, error.ParseError) {
  use tokens <- result.try(source |> lexer.new |> lexer.tokenize)
  use ast <- result.try(tokens |> parser.parse)

  ast |> evaluator.evaluate
}

pub fn parse_bits(source: BitArray) -> Result(Value, error.ParseError) {
  case source |> bit_array.to_string {
    Ok(str) -> str |> parse
    Error(_) -> Error(error.InvalidFormat)
  }
}
