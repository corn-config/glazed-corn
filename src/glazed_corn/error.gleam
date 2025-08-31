pub type ParseError {
  InvalidFormat
  InvalidLength
  UnexpectedToken(String)
  UnexpectedEof
  MissingInput(String)
  InvalidSpread
  InvalidChain
}
