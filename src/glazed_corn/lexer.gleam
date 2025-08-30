import glazed_corn
import gleam/float
import gleam/list
import gleam/result
import gleam/string
import splitter

pub type Token {
  Let
  In
  Null
  Equals
  OpenBrace
  CloseBrace
  OpenBracket
  CloseBracket
  Spread
  Chain
  Boolean(Bool)
  Integer(Int)
  Float(Float)
  InputName(String)
  Literal(String)
  // Literal(Vec<StringPart<'input>>),
  Key(String)
  Comment(String)
  Eof
}

pub fn tokenize(
  source: String,
  tokens: List(Token),
) -> Result(List(Token), glazed_corn.ParseError) {
  case source |> string.trim_start |> next {
    Ok(#(Eof, _)) -> Ok(tokens |> list.reverse)
    Ok(#(token, rest)) -> tokenize(rest, [token, ..tokens])
    Error(error) -> Error(error)
  }
}

const whitespace_codepoints: List(String) = [
  // Tab
  "\u{0009}",
  // Line Feed
  "\u{000A}",
  // Vertical Tab
  "\u{000B}",
  // Form Feed
  "\u{000C}",
  // Carriage Return
  "\u{000D}",
  // Space
  "\u{0020}",
  // Next Line
  "\u{0085}",
  // No-Break Space
  "\u{00A0}",
  // Ogham Space Mark
  "\u{1680}",
  // En Quad
  "\u{2000}",
  // Em Quad
  "\u{2001}",
  // En Space
  "\u{2002}",
  // Em Space
  "\u{2003}",
  // Three-Per-Em Space
  "\u{2004}",
  // Four-Per-Em Space
  "\u{2005}",
  // Six-Per-Em Space
  "\u{2006}",
  // Figure Space
  "\u{2007}",
  // Punctuation Space
  "\u{2008}",
  // Thin Space
  "\u{2009}",
  // Hair Space
  "\u{200A}",
  // Line Separator
  "\u{2028}",
  // Paragraph Separator
  "\u{2029}",
  // Narrow No-Break Space
  "\u{202F}",
  // Medium Mathematical Space
  "\u{205F}",
  // Ideographic Space
  "\u{3000}",
]

fn next(source: String) -> Result(#(Token, String), glazed_corn.ParseError) {
  let new_line_splitter = splitter.new(["\n", "\r\n"])
  let string_splitter = splitter.new(["\""])
  let key_splitter = splitter.new(["=", ".", ..whitespace_codepoints])
  let whitespace_splitter = splitter.new(whitespace_codepoints)

  case source {
    "" -> #(Eof, "") |> Ok

    "=" <> rest -> #(Equals, rest) |> Ok
    "{" <> rest -> #(OpenBrace, rest) |> Ok
    "}" <> rest -> #(CloseBrace, rest) |> Ok
    "[" <> rest -> #(OpenBracket, rest) |> Ok
    "]" <> rest -> #(CloseBracket, rest) |> Ok
    ".." <> rest -> #(Spread, rest) |> Ok
    "." <> rest -> #(Chain, rest) |> Ok

    "//" <> rest -> {
      let #(before, _split, after) = new_line_splitter |> splitter.split(rest)

      #(Comment(before |> string.trim_start), after) |> Ok
    }

    "\"" <> rest -> {
      let #(before, _split, after) = string_splitter |> splitter.split(rest)

      #(Literal(before |> string.trim_start), after) |> Ok
    }

    "-" <> rest -> lex_num(rest, True)
    "0" <> _
    | "1" <> _
    | "2" <> _
    | "3" <> _
    | "4" <> _
    | "5" <> _
    | "6" <> _
    | "7" <> _
    | "8" <> _
    | "9" <> _ -> lex_num(source, False)

    "$" <> name -> {
      case name |> is_valid_start {
        True -> {
          let #(input, rest) = lex_input_name(name, "")

          Ok(#(InputName(input), rest))
        }
        False -> Error(glazed_corn.InvalidFormat)
      }
    }
    _ -> {
      let #(before, _, after) = whitespace_splitter |> splitter.split(source)

      case before {
        "let" -> #(Let, after) |> Ok
        "in" -> #(In, after) |> Ok
        "null" -> #(Null, after) |> Ok
        "false" -> #(Boolean(False), after) |> Ok
        "true" -> #(Boolean(True), after) |> Ok

        _ -> {
          let #(before, split, after) = key_splitter |> splitter.split(source)

          Ok(#(Key(before), split <> after))
        }
      }
    }
  }
}

fn is_valid_start(source: String) -> Bool {
  case source {
    "_" <> _
    | "$" <> _
    | "a" <> _
    | "b" <> _
    | "c" <> _
    | "d" <> _
    | "e" <> _
    | "f" <> _
    | "g" <> _
    | "h" <> _
    | "i" <> _
    | "j" <> _
    | "k" <> _
    | "l" <> _
    | "m" <> _
    | "n" <> _
    | "o" <> _
    | "p" <> _
    | "q" <> _
    | "r" <> _
    | "s" <> _
    | "t" <> _
    | "u" <> _
    | "v" <> _
    | "w" <> _
    | "x" <> _
    | "y" <> _
    | "z" <> _
    | "A" <> _
    | "B" <> _
    | "C" <> _
    | "D" <> _
    | "E" <> _
    | "F" <> _
    | "G" <> _
    | "H" <> _
    | "I" <> _
    | "J" <> _
    | "K" <> _
    | "L" <> _
    | "M" <> _
    | "N" <> _
    | "O" <> _
    | "P" <> _
    | "Q" <> _
    | "R" <> _
    | "S" <> _
    | "T" <> _
    | "U" <> _
    | "V" <> _
    | "W" <> _
    | "X" <> _
    | "Y" <> _
    | "Z" <> _ -> True
    _ -> False
  }
}

fn lex_input_name(source: String, acc: String) -> #(String, String) {
  case source {
    "_" as character <> source
    | "$" as character <> source
    | "a" as character <> source
    | "b" as character <> source
    | "c" as character <> source
    | "d" as character <> source
    | "e" as character <> source
    | "f" as character <> source
    | "g" as character <> source
    | "h" as character <> source
    | "i" as character <> source
    | "j" as character <> source
    | "k" as character <> source
    | "l" as character <> source
    | "m" as character <> source
    | "n" as character <> source
    | "o" as character <> source
    | "p" as character <> source
    | "q" as character <> source
    | "r" as character <> source
    | "s" as character <> source
    | "t" as character <> source
    | "u" as character <> source
    | "v" as character <> source
    | "w" as character <> source
    | "x" as character <> source
    | "y" as character <> source
    | "z" as character <> source
    | "A" as character <> source
    | "B" as character <> source
    | "C" as character <> source
    | "D" as character <> source
    | "E" as character <> source
    | "F" as character <> source
    | "G" as character <> source
    | "H" as character <> source
    | "I" as character <> source
    | "J" as character <> source
    | "K" as character <> source
    | "L" as character <> source
    | "M" as character <> source
    | "N" as character <> source
    | "O" as character <> source
    | "P" as character <> source
    | "Q" as character <> source
    | "R" as character <> source
    | "S" as character <> source
    | "T" as character <> source
    | "U" as character <> source
    | "V" as character <> source
    | "W" as character <> source
    | "X" as character <> source
    | "Y" as character <> source
    | "Z" as character <> source
    | "0" as character <> source
    | "1" as character <> source
    | "2" as character <> source
    | "3" as character <> source
    | "4" as character <> source
    | "5" as character <> source
    | "6" as character <> source
    | "7" as character <> source
    | "8" as character <> source
    | "9" as character <> source -> lex_input_name(source, acc <> character)

    rest -> #(acc, rest)
  }
}

fn lex_num(
  source: String,
  negative: Bool,
) -> Result(#(Token, String), glazed_corn.ParseError) {
  let float_splitter = splitter.new([".", ..whitespace_codepoints])

  let #(before, split, after) = float_splitter |> splitter.split(source)

  case split {
    "." -> {
      let #(num, rest) = after |> string.trim_start |> split_float("")

      float.parse(before <> "." <> num)
      |> result.map(fn(f) { #(Float(f), rest) })
      |> result.replace_error(glazed_corn.InvalidFormat)
    }
    _ -> {
      let #(num, rest) = source |> string.trim_start |> parse_num(0)

      case rest {
        "" <> rest -> {
          case negative {
            False -> Ok(#(Integer(num), rest))
            True -> Ok(#(Integer(-num), rest))
          }
        }
        _ -> Error(glazed_corn.InvalidFormat)
      }
    }
  }
}

fn split_float(source: String, lex: String) -> #(String, String) {
  case source {
    "0" as c <> rest
    | "1" as c <> rest
    | "2" as c <> rest
    | "3" as c <> rest
    | "4" as c <> rest
    | "5" as c <> rest
    | "6" as c <> rest
    | "7" as c <> rest
    | "8" as c <> rest
    | "9" as c <> rest
    | "e-" as c <> rest
    | "e+" as c <> rest -> split_float(rest, lex <> c)
    rest -> #(lex, rest)
  }
}

fn parse_num(source: String, significand: Int) -> #(Int, String) {
  case source {
    "0" <> rest -> parse_num(rest, significand * 10)
    "1" <> rest -> parse_num(rest, significand * 10 + 1)
    "2" <> rest -> parse_num(rest, significand * 10 + 2)
    "3" <> rest -> parse_num(rest, significand * 10 + 3)
    "4" <> rest -> parse_num(rest, significand * 10 + 4)
    "5" <> rest -> parse_num(rest, significand * 10 + 5)
    "6" <> rest -> parse_num(rest, significand * 10 + 6)
    "7" <> rest -> parse_num(rest, significand * 10 + 7)
    "8" <> rest -> parse_num(rest, significand * 10 + 8)
    "9" <> rest -> parse_num(rest, significand * 10 + 9)
    "_" <> rest -> parse_num(rest, significand)
    rest -> #(significand, rest)
  }
}
