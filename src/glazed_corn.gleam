import glazed_corn/value.{type Value}
import gleam/bit_array

pub type Error {
  Error
}

pub fn parse(source: String) -> Result(Value, Error) {
  parse_bits(bit_array.from_string(source))
}

pub fn parse_bits(source: BitArray) -> Result(Value, Error) {
  todo
}
