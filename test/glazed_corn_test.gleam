import glazed_corn
import glazed_corn/value
import gleam/json
import gleeunit
import simplifile.{read}

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn array_single_null_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/array/single_null.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/array/single_null.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn array_single_test() {
  let assert Ok(corn_source) = read("test-suite/corn/array/single.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/array/single.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn array_nested_object_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/array/nested_object.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/array/nested_object.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn array_nested_array_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/array/nested_array.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/array/nested_array.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn array_mixed_basic_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/array/mixed_basic.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/array/mixed_basic.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn array_empty_test() {
  let assert Ok(corn_source) = read("test-suite/corn/array/empty.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/array/empty.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn array_compact_inputs_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/array/compact_inputs.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn array_compact_test() {
  let assert Ok(corn_source) = read("test-suite/corn/array/compact.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn array_brackets_none_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/array/brackets_none.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn array_brackets_no_open_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/array/brackets_no_open.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn array_brackets_no_close_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/array/brackets_no_close.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn array_spread_two_test() {
  let assert Ok(corn_source) = read("test-suite/corn/array/spread/two.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/array/spread/two.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn array_spread_start_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/array/spread/start.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/array/spread/start.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn array_spread_input_undefined_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/array/spread/input_undefined.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn array_spread_input_invalid_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/array/spread/input_invalid.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn array_spread_end_test() {
  let assert Ok(corn_source) = read("test-suite/corn/array/spread/end.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/array/spread/end.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn array_spread_dot_triple_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/array/spread/dot_triple.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn array_spread_dot_single_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/array/spread/dot_single.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn array_spread_center_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/array/spread/center.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/array/spread/center.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn array_spread_basic_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/array/spread/basic.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/array/spread/basic.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn boolean_null_true_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/boolean_null/true.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/boolean_null/true.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn boolean_null_null_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/boolean_null/null.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/boolean_null/null.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn boolean_null_false_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/boolean_null/false.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/boolean_null/false.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn comment_mixed_test() {
  let assert Ok(corn_source) = read("test-suite/corn/comment/mixed.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/comment/mixed.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn comment_empty_test() {
  let assert Ok(corn_source) = read("test-suite/corn/comment/empty.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/comment/empty.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn float_zero_test() {
  let assert Ok(corn_source) = read("test-suite/corn/float/zero.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/float/zero.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn float_positive_test() {
  let assert Ok(corn_source) = read("test-suite/corn/float/positive.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/float/positive.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn float_plus_test() {
  let assert Ok(corn_source) = read("test-suite/corn/float/plus.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn float_negative_test() {
  let assert Ok(corn_source) = read("test-suite/corn/float/negative.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/float/negative.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn float_exponent_positive_positive_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/float/exponent/positive_positive.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/float/exponent/positive_positive.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn float_exponent_positive_negative_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/float/exponent/positive_negative.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/float/exponent/positive_negative.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn float_exponent_no_value_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/float/exponent/no_value.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn float_exponent_no_sign_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/float/exponent/no_sign.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn float_exponent_no_exponent_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/float/exponent/no_exponent.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn float_exponent_negative_positive_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/float/exponent/negative_positive.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/float/exponent/negative_positive.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn float_exponent_negative_negative_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/float/exponent/negative_negative.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/float/exponent/negative_negative.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn input_underscore_start_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/input/underscore_start.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/input/underscore_start.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn input_underscore_end_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/input/underscore_end.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/input/underscore_end.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn input_underscore_center_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/input/underscore_center.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/input/underscore_center.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn input_undefined_test() {
  let assert Ok(corn_source) = read("test-suite/corn/input/undefined.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn input_number_start_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/input/number_start.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn input_number_end_test() {
  let assert Ok(corn_source) = read("test-suite/corn/input/number_end.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/input/number_end.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn input_number_center_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/input/number_center.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/input/number_center.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn input_let_empty_test() {
  let assert Ok(corn_source) = read("test-suite/corn/input/let_empty.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/input/let_empty.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn input_env_undefined_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/input/env_undefined.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn input_env_default_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/input/env_default.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/input/env_default.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn input_env_test() {
  let assert Ok(corn_source) = read("test-suite/corn/input/env.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/input/env.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn input_complex_name_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/input/complex_name.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/input/complex_name.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn input_caps_start_test() {
  let assert Ok(corn_source) = read("test-suite/corn/input/caps_start.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/input/caps_start.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn input_caps_end_test() {
  let assert Ok(corn_source) = read("test-suite/corn/input/caps_end.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/input/caps_end.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn input_caps_center_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/input/caps_center.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/input/caps_center.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn input_basic_test() {
  let assert Ok(corn_source) = read("test-suite/corn/input/basic.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/input/basic.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_binary_zero_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/binary/zero.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/integer/binary/zero.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_binary_positive_overflow_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/binary/positive_overflow.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_binary_positive_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/binary/positive.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/integer/binary/positive.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_binary_plus_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/binary/plus.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_binary_no_value_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/binary/no_value.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_binary_negative_overflow_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/binary/negative_overflow.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_binary_negative_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/binary/negative.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/integer/binary/negative.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_binary_invalid_digits_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/binary/invalid_digits.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_binary_underscore_positive_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/binary/underscore/positive.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/integer/binary/underscore/positive.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_binary_underscore_negative_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/binary/underscore/negative.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/integer/binary/underscore/negative.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_binary_underscore_double_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/binary/underscore/double.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_binary_underscore_before_value_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/binary/underscore/before_value.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_binary_underscore_before_prefix_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/binary/underscore/before_prefix.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_binary_underscore_after_value_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/binary/underscore/after_value.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_decimal_zero_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/decimal/zero.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/integer/decimal/zero.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_decimal_positive_overflow_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/decimal/positive_overflow.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_decimal_positive_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/decimal/positive.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/integer/decimal/positive.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_decimal_plus_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/decimal/plus.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_decimal_negative_overflow_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/decimal/negative_overflow.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_decimal_negative_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/decimal/negative.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/integer/decimal/negative.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_decimal_invalid_digits_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/decimal/invalid_digits.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_decimal_underscore_positive_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/decimal/underscore/positive.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/integer/decimal/underscore/positive.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_decimal_underscore_negative_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/decimal/underscore/negative.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/integer/decimal/underscore/negative.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_decimal_underscore_double_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/decimal/underscore/double.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_decimal_underscore_before_value_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/decimal/underscore/before_value.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_decimal_underscore_after_value_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/decimal/underscore/after_value.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_hexadecimal_zero_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/hexadecimal/zero.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/integer/hexadecimal/zero.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_hexadecimal_positive_overflow_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/hexadecimal/positive_overflow.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_hexadecimal_positive_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/hexadecimal/positive.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/integer/hexadecimal/positive.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_hexadecimal_plus_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/hexadecimal/plus.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_hexadecimal_no_value_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/hexadecimal/no_value.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_hexadecimal_negative_overflow_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/hexadecimal/negative_overflow.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_hexadecimal_negative_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/hexadecimal/negative.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/integer/hexadecimal/negative.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_hexadecimal_invalid_digits_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/hexadecimal/invalid_digits.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_hexadecimal_underscore_positive_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/hexadecimal/underscore/positive.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/integer/hexadecimal/underscore/positive.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_hexadecimal_underscore_negative_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/hexadecimal/underscore/negative.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/integer/hexadecimal/underscore/negative.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_hexadecimal_underscore_double_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/hexadecimal/underscore/double.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_hexadecimal_underscore_before_value_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/hexadecimal/underscore/before_value.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_hexadecimal_underscore_before_prefix_test() {
  let assert Ok(corn_source) =
    read(
      "test-suite/corn/integer/hexadecimal/underscore/before_prefix.neg.corn",
    )
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_hexadecimal_underscore_after_value_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/hexadecimal/underscore/after_value.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_octal_zero_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/octal/zero.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/integer/octal/zero.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_octal_positive_overflow_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/octal/positive_overflow.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_octal_positive_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/octal/positive.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/integer/octal/positive.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_octal_plus_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/octal/plus.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_octal_no_value_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/octal/no_value.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_octal_negative_overflow_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/octal/negative_overflow.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_octal_negative_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/octal/negative.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/integer/octal/negative.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_octal_invalid_digits_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/octal/invalid_digits.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_octal_underscore_positive_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/octal/underscore/positive.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/integer/octal/underscore/positive.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_octal_underscore_negative_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/octal/underscore/negative.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/integer/octal/underscore/negative.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn integer_octal_underscore_double_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/octal/underscore/double.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_octal_underscore_before_value_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/octal/underscore/before_value.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_octal_underscore_before_prefix_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/octal/underscore/before_prefix.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn integer_octal_underscore_after_value_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/integer/octal/underscore/after_value.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn object_two_keys_test() {
  let assert Ok(corn_source) = read("test-suite/corn/object/two_keys.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/object/two_keys.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn object_single_null_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/object/single_null.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/object/single_null.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn object_single_test() {
  let assert Ok(corn_source) = read("test-suite/corn/object/single.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/object/single.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn object_no_value_test() {
  let assert Ok(corn_source) = read("test-suite/corn/object/no_value.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn object_no_key_test() {
  let assert Ok(corn_source) = read("test-suite/corn/object/no_key.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn object_no_equals_test() {
  let assert Ok(corn_source) = read("test-suite/corn/object/no_equals.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn object_nested_object_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/object/nested_object.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/object/nested_object.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn object_nested_array_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/object/nested_array.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/object/nested_array.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn object_mixed_basic_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/object/mixed_basic.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/object/mixed_basic.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn object_empty_test() {
  let assert Ok(corn_source) = read("test-suite/corn/object/empty.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/object/empty.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn object_compact_test() {
  let assert Ok(corn_source) = read("test-suite/corn/object/compact.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn object_braces_none_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/object/braces_none.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn object_braces_no_open_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/object/braces_no_open.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn object_braces_no_close_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/object/braces_no_close.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn object_spread_two_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/object/spread/two.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/object/spread/two.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn object_spread_start_overwrite_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/object/spread/start_overwrite.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/object/spread/start_overwrite.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn object_spread_start_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/object/spread/start.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/object/spread/start.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn object_spread_input_undefined_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/object/spread/input_undefined.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn object_spread_input_invalid_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/object/spread/input_invalid.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn object_spread_end_overwrite_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/object/spread/end_overwrite.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/object/spread/end_overwrite.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn object_spread_end_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/object/spread/end.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/object/spread/end.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn object_spread_dot_triple_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/object/spread/dot_triple.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn object_spread_dot_single_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/object/spread/dot_single.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn object_spread_center_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/object/spread/center.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/object/spread/center.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn object_spread_basic_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/object/spread/basic.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/object/spread/basic.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_unicode_test() {
  let assert Ok(corn_source) = read("test-suite/corn/string/unicode.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/string/unicode.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_multiline_test() {
  let assert Ok(corn_source) = read("test-suite/corn/string/multiline.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/string/multiline.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_empty_test() {
  let assert Ok(corn_source) = read("test-suite/corn/string/empty.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/string/empty.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_char_test() {
  let assert Ok(corn_source) = read("test-suite/corn/string/char.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/string/char.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_ascii_test() {
  let assert Ok(corn_source) = read("test-suite/corn/string/ascii.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/string/ascii.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_escape_tab_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/escape/tab.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/string/escape/tab.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_escape_speech_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/escape/speech.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/string/escape/speech.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_escape_newline_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/escape/newline.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/string/escape/newline.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_escape_carriage_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/escape/carriage.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/string/escape/carriage.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_escape_backslash_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/escape/backslash.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/string/escape/backslash.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_escape_all_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/escape/all.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/string/escape/all.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_escape_unicode_two_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/escape/unicode/two.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/string/escape/unicode/two.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_escape_unicode_three_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/escape/unicode/three.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/string/escape/unicode/three.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_escape_unicode_six_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/escape/unicode/six.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/string/escape/unicode/six.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_escape_unicode_one_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/escape/unicode/one.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/string/escape/unicode/one.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_escape_unicode_no_open_brace_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/escape/unicode/no_open_brace.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn string_escape_unicode_no_code_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/escape/unicode/no_code.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn string_escape_unicode_no_close_brace_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/escape/unicode/no_close_brace.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn string_escape_unicode_no_braces_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/escape/unicode/no_braces.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn string_escape_unicode_invalid_code_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/escape/unicode/invalid_code.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn string_escape_unicode_four_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/escape/unicode/four.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/string/escape/unicode/four.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_escape_unicode_five_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/escape/unicode/five.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/string/escape/unicode/five.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_interpolation_two_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/interpolation/two.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/string/interpolation/two.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_interpolation_start_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/interpolation/start.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/string/interpolation/start.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_interpolation_no_braces_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/interpolation/no_braces.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/string/interpolation/no_braces.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_interpolation_input_undefined_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/interpolation/input_undefined.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn string_interpolation_input_invalid_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/interpolation/input_invalid.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn string_interpolation_escape_undefined_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/interpolation/escape_undefined.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/string/interpolation/escape_undefined.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_interpolation_escape_defined_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/interpolation/escape_defined.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/string/interpolation/escape_defined.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_interpolation_escape_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/interpolation/escape.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn string_interpolation_env_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/interpolation/env.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/string/interpolation/env.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_interpolation_end_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/interpolation/end.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/string/interpolation/end.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_interpolation_center_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/interpolation/center.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/string/interpolation/center.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn string_interpolation_basic_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/string/interpolation/basic.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/string/interpolation/basic.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn whitespace_spacious_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/whitespace/spacious.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/whitespace/spacious.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn whitespace_compact_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/whitespace/compact.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/whitespace/compact.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn key_unicode_test() {
  let assert Ok(corn_source) = read("test-suite/corn/key/unicode.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/key/unicode.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn key_underscore_test() {
  let assert Ok(corn_source) = read("test-suite/corn/key/underscore.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/key/underscore.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn key_symbols_test() {
  let assert Ok(corn_source) = read("test-suite/corn/key/symbols.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/key/symbols.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn key_speech_test() {
  let assert Ok(corn_source) = read("test-suite/corn/key/speech.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn key_space_test() {
  let assert Ok(corn_source) = read("test-suite/corn/key/space.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn key_quote_test() {
  let assert Ok(corn_source) = read("test-suite/corn/key/quote.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn key_numbers_test() {
  let assert Ok(corn_source) = read("test-suite/corn/key/numbers.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/key/numbers.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn key_equals_test() {
  let assert Ok(corn_source) = read("test-suite/corn/key/equals.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn key_dash_test() {
  let assert Ok(corn_source) = read("test-suite/corn/key/dash.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/key/dash.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn key_basic_test() {
  let assert Ok(corn_source) = read("test-suite/corn/key/basic.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/key/basic.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn key_chaining_triple_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/key/chaining/triple.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/key/chaining/triple.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn key_chaining_start_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/key/chaining/start.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/key/chaining/start.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn key_chaining_invalid_type_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/key/chaining/invalid_type.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn key_chaining_end_test() {
  let assert Ok(corn_source) = read("test-suite/corn/key/chaining/end.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/key/chaining/end.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn key_chaining_dot_trailing_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/key/chaining/dot_trailing.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn key_chaining_dot_double_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/key/chaining/dot_double.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn key_chaining_basic_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/key/chaining/basic.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/key/chaining/basic.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn key_quoted_speech_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/key/quoted/speech.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/key/quoted/speech.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn key_quoted_space_test() {
  let assert Ok(corn_source) = read("test-suite/corn/key/quoted/space.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/key/quoted/space.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn key_quoted_no_open_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/key/quoted/no_open.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn key_quoted_no_close_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/key/quoted/no_close.neg.corn")
  let assert Error(_) = glazed_corn.parse(corn_source)
}

pub fn key_quoted_escape_quote_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/key/quoted/escape_quote.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/key/quoted/escape_quote.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn key_quoted_equals_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/key/quoted/equals.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/key/quoted/equals.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn key_quoted_chaining_mixed_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/key/quoted/chaining_mixed.pos.corn")
  let assert Ok(json_source) =
    read("test-suite/json/key/quoted/chaining_mixed.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn key_quoted_chaining_test() {
  let assert Ok(corn_source) =
    read("test-suite/corn/key/quoted/chaining.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/key/quoted/chaining.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}

pub fn key_quoted_basic_test() {
  let assert Ok(corn_source) = read("test-suite/corn/key/quoted/basic.pos.corn")
  let assert Ok(json_source) = read("test-suite/json/key/quoted/basic.json")

  let assert Ok(parsed_corn) = glazed_corn.parse(corn_source)
  let assert Ok(parsed_json) = json.parse(json_source, value.decoder())

  assert parsed_corn == parsed_json
}
