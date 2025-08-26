import glazed_corn/value.{type Value}
import gleam/bit_array

pub type Error {
  Error
}

pub fn parse(source: String) -> Result(Value, Error) {
  parse_bits(bit_array.from_string(source))
}

pub fn parse_bits(_source: BitArray) -> Result(Value, Error) {
  Ok(value.Null)
}
