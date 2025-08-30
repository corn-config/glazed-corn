import glazed_corn/lexer
import glazed_corn/parser
import gleam/io
import gleam/list
import gleam/string
import simplifile

pub fn main() {
  let assert Ok(cases) = simplifile.get_files("test-suite/corn")

  // let cases = ["test-suite/corn/key/quoted/chaining.pos.corn"]

  cases
  |> list.filter(fn(t) { t |> string.ends_with(".pos.corn") })
  |> list.each(fn(t) {
    let assert Ok(src) = simplifile.read(t)
    io.println(
      "\n\n"
      <> "-" |> string.repeat(60)
      <> "\n"
      <> t
      <> "\n"
      <> "-" |> string.repeat(60)
      <> "\n\n"
      <> src
      <> "\n\n"
      <> "-" |> string.repeat(60),
    )

    let assert Ok(tokens) = src |> lexer.new |> lexer.tokenize

    echo tokens

    let assert Ok(entry) = tokens |> parser.parse_entry

    echo entry
  })
}
