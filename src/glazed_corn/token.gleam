import gleam/float
import gleam/int

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

pub fn to_string(token: Token) -> String {
  case token {
    Let -> "Let"
    In -> "In"
    Null -> "Null"
    Equals -> "Equals"
    OpenBrace -> "OpenBrace"
    CloseBrace -> "CloseBrace"
    OpenBracket -> "OpenBracket"
    CloseBracket -> "CloseBracket"
    Spread -> "Spread"
    Chain -> "Chain"
    Boolean(b) ->
      "Boolean("
      <> case b {
        True -> "True"
        False -> "False"
      }
      <> ")"
    Integer(i) -> "Integer(" <> int.to_string(i) <> ")"
    Float(f) -> "Float(" <> float.to_string(f) <> ")"
    InputName(s) -> "InputName(\"" <> s <> "\")"
    Literal(s) -> "Literal(\"" <> s <> "\")"
    Key(s) -> "Key(\"" <> s <> "\")"
    Comment(s) -> "Comment(\"" <> s <> "\")"
    Eof -> "Eof"
  }
}
