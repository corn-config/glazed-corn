import gleam/dict.{type Dict}
import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode.{type Decoder}

pub type Value {
  String(String)
  Integer(Int)
  Float(Float)
  Boolean(Bool)
  Object(Dict(String, Value))
  Array(List(Value))
  Null
}

pub fn from_dynamic(dynamic: Dynamic) -> Result(Value, List(decode.DecodeError)) {
  decode.run(dynamic, decoder())
}

pub fn decoder() -> Decoder(Value) {
  use <- decode.recursive
  decode.one_of(decode.string |> decode.map(String), [
    decode.int |> decode.map(Integer),
    decode.float |> decode.map(Float),
    decode.bool |> decode.map(Boolean),
    decode.dict(decode.string, decoder()) |> decode.map(Object),
    decode.list(decoder()) |> decode.map(Array),
    // TODO: make this nice, maybe open a pr for a decode.none decoder
    decode.optional(decode.failure(Null, "Value")) |> decode.map(fn(_) { Null }),
  ])
}
