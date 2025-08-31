pub type ParseError {
  InvalidFormat
  InvalidLength
  UnexpectedToken(String)
  UnexpectedEof
}
