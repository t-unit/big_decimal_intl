import 'package:big_decimal/big_decimal.dart';
import 'package:big_decimal_intl/src/big_decimal_num.dart';
import 'package:test/test.dart';

void main() {
  final zero = BigDecimalNum(BigDecimal.zero);
  final one = BigDecimalNum(BigDecimal.one);
  final two = BigDecimalNum(BigDecimal.two);
  final three = BigDecimalNum(BigDecimal.parse('3.000'));
  final four = BigDecimalNum(BigDecimal.parse('4.000'));

  test('compareTo', () {
    expect(one.compareTo(2), -1);
    expect(one.compareTo(1), 0);
    expect(two.compareTo(1), 1);
  });

  test('+', () {
    expect(one + 2, three);
    expect(one + 1.0, two);
    expect(two + 1, three);
  });

  test('-', () {
    expect(three - 2, one);
    expect(two - 1, one);
    expect(three - 1, two);
  });

  test('*', () {
    expect(two * 2, four);
    expect(one * 3.0, three);
    expect(two * 1, two);
  });

  test('%', () {
    expect(four % 3, one);
    expect(four % 2, zero);
    expect(four % 1, zero);
  });

  test('/', () {
    expect(four / 2, 2.0);
    expect(four / 3.0, 1.333);
    expect(four / 1, 4.0);
  });

  test('~/', () {
    expect(four ~/ 2, 2);
    expect(four ~/ 3.0, 1);
    expect(four ~/ 1, 4);
  });

  test('-', () {
    expect(-BigDecimalNum(-BigDecimal.one), one);
    expect(-two, BigDecimalNum(-BigDecimal.two));
  });

  test('remainder', () {
    expect(four.remainder(3), one);
    expect(four.remainder(2), zero);
    expect(four.remainder(1), zero);
  });

  test('<', () {
    expect(one < 2, true);
    expect(one < 1, false);
    expect(two < 1, false);
  });

  test('<=', () {
    expect(one <= 2, true);
    expect(one <= 1, true);
    expect(two <= 1, false);
  });

  test('>', () {
    expect(one > 2, false);
    expect(one > 1, false);
    expect(two > 1, true);
  });

  test('>=', () {
    expect(one >= 2, false);
    expect(one >= 1, true);
    expect(two >= 1, true);
  });

  test('isNegative', () {
    expect(one.isNegative, false);
    expect(BigDecimalNum(-BigDecimal.one).isNegative, true);
  });

  test('abs', () {
    expect(one.abs(), one);
    expect(BigDecimalNum(-BigDecimal.one).abs(), one);
  });

  test('sign', () {
    expect(one.sign, one);
    expect(-two.sign, -one);
    expect(zero.sign, zero);
  });

  test('round', () {
    expect(BigDecimalNum(BigDecimal.parse('1.5')).round(), two);
    expect(BigDecimalNum(BigDecimal.parse('1.4')).round(), one);
    expect(BigDecimalNum(BigDecimal.parse('1.6')).round(), two);
  });

  test('floor', () {
    expect(BigDecimalNum(BigDecimal.parse('1.5')).floor(), one);
    expect(BigDecimalNum(BigDecimal.parse('1.4')).floor(), one);
    expect(BigDecimalNum(BigDecimal.parse('1.6')).floor(), one);
  });

  test('ceil', () {
    expect(BigDecimalNum(BigDecimal.parse('1.5')).ceil(), two);
    expect(BigDecimalNum(BigDecimal.parse('1.4')).ceil(), two);
    expect(BigDecimalNum(BigDecimal.parse('1.6')).ceil(), two);
  });

  test('truncate', () {
    expect(BigDecimalNum(BigDecimal.parse('1.5')).truncate(), one);
    expect(BigDecimalNum(BigDecimal.parse('1.4')).truncate(), one);
    expect(BigDecimalNum(BigDecimal.parse('1.6')).truncate(), one);
    expect(BigDecimalNum(BigDecimal.parse('-1.5')).truncate(), -one);
    expect(BigDecimalNum(BigDecimal.parse('-1.4')).truncate(), -one);
    expect(BigDecimalNum(BigDecimal.parse('-1.6')).truncate(), -one);
  });

  test('clamp', () {
    expect(one.clamp(2, 3), two);
    expect(one.clamp(0, 1), one);
    expect(one.clamp(0, 0), zero);
  });
}
