import filepath
import gleam/list
import gleam/string
import simplifile

type Test {
  Pass(name: String, corn_path: String, json_path: String)
  Fail(name: String, corn_path: String)
}

fn test_to_string(test_case: Test) -> String {
  case test_case {
    Fail(name:, corn_path:) -> "pub fn " <> name <> "() {
let assert Error(_) = read_bits(\"" <> corn_path <> "\")
}
"
    Pass(name:, corn_path:, json_path:) -> "pub fn " <> name <> "() {
let assert Ok(corn_source) = read_bits(\"" <> corn_path <> "\")
let assert Ok(json_source) = read_bits(\"" <> json_path <> "\")

let assert Ok(parsed_corn) = glazed_corn.parse_bits(corn_source)
let assert Ok(parsed_json) = json.parse_bits(json_source, value.decoder())

assert parsed_corn == parsed_json
}
"
  }
}

fn path_to_test(path: String) -> Test {
  let name =
    filepath.split(path)
    |> list.drop(2)
    |> string.join("_")
    |> string.replace(".pos.corn", "")
    |> string.replace(".neg.corn", "")
    <> "_test"

  case path |> string.ends_with(".pos.corn") {
    True ->
      Pass(
        name,
        corn_path: path,
        json_path: path |> string.replace(".pos.corn", ".json"),
      )
    False -> Fail(name, corn_path: path)
  }
}

pub fn main() {
  let assert Ok(tests) = simplifile.get_files("test-suite/corn")

  let test_file =
    tests
    |> list.fold("", fn(acc, path) {
      acc
      <> path
      |> path_to_test
      |> test_to_string
    })

  let test_file = "import glazed_corn
import glazed_corn/value
import gleam/json
import gleeunit
import simplifile.{read_bits}

pub fn main() -> Nil {
  gleeunit.main()
}

" <> test_file

  simplifile.write("test/glazed_corn_test.gleam", test_file)
}
