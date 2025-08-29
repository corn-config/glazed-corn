import glazed_corn/value.{type Value}
import gleam/bit_array

pub type ParseError {
  InvalidFormat
  InvalidLength
  UnexpectedToken(String)
}

pub fn parse(source: String) -> Result(Value, ParseError) {
  parse_bits(bit_array.from_string(source))
}

pub fn parse_bits(source: BitArray) -> Result(Value, ParseError) {
  case parse_value(source) {
    Ok(#(value, <<>>)) -> Ok(value)
    Ok(#(_, _)) -> Error(InvalidLength)
    Error(error) -> Error(error)
  }
}

pub fn parse_value(source: BitArray) -> Result(#(Value, BitArray), ParseError) {
  Error(InvalidLength)
}
