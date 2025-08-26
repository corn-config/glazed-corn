import glazed_corn
import glazed_corn/value
import gleam/json
import gleeunit
import simplifile.{read_bits}

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn single_test() {
  let assert Ok(corn_source) =
    read_bits("test-suite/corn/object/single.pos.corn")
  let assert Ok(json_source) = read_bits("test-suite/json/object/single.json")

  let assert Ok(parsed_corn) = glazed_corn.parse_bits(corn_source)
  let assert Ok(parsed_json) = json.parse_bits(json_source, value.decoder())

  assert parsed_corn == parsed_json
}
