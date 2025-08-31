import glazed_corn/error
import glazed_corn/token.{
  type Token, Boolean, Chain, CloseBrace, CloseBracket, Comment, Eof, Equals,
  Float, In, InputName, Integer, Key, Let, Literal, Null, OpenBrace, OpenBracket,
  Spread,
}

import gleam/float
import gleam/int
import gleam/list
import gleam/result
import gleam/string
import splitter.{type Splitter}

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

pub opaque type Lexer {
  Lexer(
    source: String,
    new_line_splitter: Splitter,
    string_splitter: Splitter,
    key_splitter: Splitter,
    quoted_key_splitter: Splitter,
    float_splitter: Splitter,
  )
}

pub fn new(source: String) -> Lexer {
  Lexer(
    source:,
    new_line_splitter: splitter.new(["\n", "\r\n"]),
    string_splitter: splitter.new(["\\\\", "\\\"", "\\n", "\\r", "\\t", "\""]),
    key_splitter: splitter.new(["=", ".", ..whitespace_codepoints]),
    quoted_key_splitter: splitter.new(["\\'", "'"]),
    float_splitter: splitter.new([".", ..whitespace_codepoints]),
  )
}

fn advance(lexer: Lexer, source: String) -> Lexer {
  Lexer(..lexer, source:)
}

pub fn tokenize(lexer: Lexer) -> Result(List(Token), error.ParseError) {
  do_tokenize(lexer, [])
}

fn do_tokenize(
  lexer: Lexer,
  tokens: List(Token),
) -> Result(List(Token), error.ParseError) {
  case lexer |> advance(lexer.source |> string.trim_start) |> next {
    Ok(#(Eof, _)) -> Ok(tokens |> list.reverse)
    Ok(#(token, lexer)) -> do_tokenize(lexer, [token, ..tokens])
    Error(error) -> Error(error)
  }
}

fn next(lexer: Lexer) -> Result(#(Token, Lexer), error.ParseError) {
  case lexer.source {
    "" -> #(Eof, lexer) |> Ok

    "=" <> rest -> #(Equals, lexer |> advance(rest)) |> Ok
    "{" <> rest -> #(OpenBrace, lexer |> advance(rest)) |> Ok
    "}" <> rest -> #(CloseBrace, lexer |> advance(rest)) |> Ok
    "[" <> rest -> #(OpenBracket, lexer |> advance(rest)) |> Ok
    "]" <> rest -> #(CloseBracket, lexer |> advance(rest)) |> Ok
    ".." <> rest -> #(Spread, lexer |> advance(rest)) |> Ok
    "." <> rest -> #(Chain, lexer |> advance(rest)) |> Ok

    "//" <> rest -> {
      let #(before, _split, after) =
        lexer.new_line_splitter |> splitter.split(rest)
      #(Comment(before |> string.trim_start), lexer |> advance(after)) |> Ok
    }

    "\"" <> rest -> lex_literal(lexer |> advance(rest), "")

    "-0x" <> rest -> lex_num_radix(lexer |> advance(rest), True, 16)
    "0x" <> rest -> lex_num_radix(lexer |> advance(rest), False, 16)

    "-0o" <> rest -> lex_num_radix(lexer |> advance(rest), True, 8)
    "0o" <> rest -> lex_num_radix(lexer |> advance(rest), False, 8)

    "-0b" <> rest -> lex_num_radix(lexer |> advance(rest), True, 2)
    "0b" <> rest -> lex_num_radix(lexer |> advance(rest), False, 2)

    "-" <> rest -> lex_num_radix(lexer |> advance(rest), True, 10)
    "0" <> _
    | "1" <> _
    | "2" <> _
    | "3" <> _
    | "4" <> _
    | "5" <> _
    | "6" <> _
    | "7" <> _
    | "8" <> _
    | "9" <> _ -> lex_num_radix(lexer, False, 10)

    "$" <> name -> {
      case name |> is_valid_start {
        True -> {
          let #(input, rest) = lex_input_name(name, "")
          Ok(#(InputName(input), lexer |> advance(rest)))
        }
        False -> Error(error.InvalidFormat)
      }
    }

    "'" <> rest -> lex_quoted_key(lexer |> advance(rest), "")

    source -> {
      let #(keyword, rest) = source |> lex_keyword("")

      case keyword {
        "let" -> #(Let, lexer |> advance(rest)) |> Ok
        "in" -> #(In, lexer |> advance(rest)) |> Ok
        "null" -> #(Null, lexer |> advance(rest)) |> Ok
        "false" -> #(Boolean(False), lexer |> advance(rest)) |> Ok
        "true" -> #(Boolean(True), lexer |> advance(rest)) |> Ok
        _ -> {
          let #(before, split, after) =
            lexer.key_splitter |> splitter.split(source)
          Ok(#(Key(before), lexer |> advance(split <> after)))
        }
      }
    }
  }
}

fn lex_quoted_key(
  lexer: Lexer,
  acc: String,
) -> Result(#(Token, Lexer), error.ParseError) {
  let #(before, split, after) =
    lexer.quoted_key_splitter |> splitter.split(lexer.source)

  case split {
    "\\'" -> lex_quoted_key(advance(lexer, after), acc <> before <> "'")
    _ -> #(Key(before), lexer |> advance(after)) |> Ok
  }
}

fn lex_literal(
  lexer: Lexer,
  acc: String,
) -> Result(#(Token, Lexer), error.ParseError) {
  let #(before, split, after) =
    lexer.string_splitter |> splitter.split(lexer.source)

  case split {
    "\\\\" -> lex_literal(advance(lexer, after), acc <> before <> "\\")
    "\\\"" -> lex_literal(advance(lexer, after), acc <> before <> "\"")
    "\\n" -> lex_literal(advance(lexer, after), acc <> before <> "\n")
    "\\r" -> lex_literal(advance(lexer, after), acc <> before <> "\r")
    "\\t" -> lex_literal(advance(lexer, after), acc <> before <> "\t")
    _ -> #(Literal(acc), lexer |> advance(after)) |> Ok
  }
}

fn lex_keyword(source: String, keyword: String) -> #(String, String) {
  case source {
    "a" as character <> rest
    | "b" as character <> rest
    | "c" as character <> rest
    | "d" as character <> rest
    | "e" as character <> rest
    | "f" as character <> rest
    | "g" as character <> rest
    | "h" as character <> rest
    | "i" as character <> rest
    | "j" as character <> rest
    | "k" as character <> rest
    | "l" as character <> rest
    | "m" as character <> rest
    | "n" as character <> rest
    | "o" as character <> rest
    | "p" as character <> rest
    | "q" as character <> rest
    | "r" as character <> rest
    | "s" as character <> rest
    | "t" as character <> rest
    | "u" as character <> rest
    | "v" as character <> rest
    | "w" as character <> rest
    | "x" as character <> rest
    | "y" as character <> rest
    | "z" as character <> rest -> lex_keyword(rest, keyword <> character)

    _ -> #(keyword, source)
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

fn lex_num_radix(
  lexer: Lexer,
  negative: Bool,
  radix: Int,
) -> Result(#(Token, Lexer), error.ParseError) {
  let #(before, split, after) =
    lexer.float_splitter |> splitter.split(lexer.source)

  case split {
    "." -> {
      let #(num, rest) = after |> string.trim_start |> split_float("")

      float.parse(before <> "." <> num)
      |> result.map(fn(f) { #(Float(f), lexer |> advance(rest)) })
      |> result.replace_error(error.InvalidFormat)
    }
    _ -> {
      let #(num, rest) = lexer.source |> extract_number("")

      case num |> int.base_parse(radix) {
        Ok(num) -> {
          case negative {
            False -> Ok(#(Integer(num), lexer |> advance(rest)))
            True -> Ok(#(Integer(-num), lexer |> advance(rest)))
          }
        }
        _ -> Error(error.InvalidFormat)
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

fn extract_number(source: String, acc: String) -> #(String, String) {
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
    | "a" as c <> rest
    | "b" as c <> rest
    | "c" as c <> rest
    | "d" as c <> rest
    | "e" as c <> rest
    | "f" as c <> rest
    | "A" as c <> rest
    | "B" as c <> rest
    | "C" as c <> rest
    | "D" as c <> rest
    | "E" as c <> rest
    | "F" as c <> rest -> extract_number(rest, acc <> c)

    "_" <> rest -> extract_number(rest, acc)

    rest -> #(acc, rest)
  }
}
