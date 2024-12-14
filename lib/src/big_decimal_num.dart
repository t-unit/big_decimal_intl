import 'package:big_decimal/big_decimal.dart';

/// A wrapper around [BigDecimal] that implements the [num] interface.
class BigDecimalNum implements Comparable<num> {
  BigDecimalNum(BigDecimal decimal) : this._bigDecimal(decimal);

  BigDecimalNum._bigDecimal(this._bigDecimal);

  factory BigDecimalNum._(dynamic number) {
    if (number is BigDecimalNum) {
      return number;
    } else if (number is BigDecimal) {
      return BigDecimalNum(number);
    } else if (number is BigInt) {
      return BigDecimalNum(BigDecimal.fromBigInt(number));
    } else if (number is int) {
      return BigDecimalNum(BigDecimal.fromBigInt(BigInt.from(number)));
    }
    return BigDecimalNum(BigDecimal.parse(number.toString()));
  }

  final BigDecimal _bigDecimal;

  @override
  int compareTo(num other) =>
      _bigDecimal.compareTo(BigDecimalNum._(other)._bigDecimal);

  BigDecimalNum operator +(num other) =>
      BigDecimalNum._(_bigDecimal + BigDecimalNum._(other)._bigDecimal);

  BigDecimalNum operator -(num other) =>
      BigDecimalNum._(_bigDecimal - BigDecimalNum._(other)._bigDecimal);

  BigDecimalNum operator *(num other) =>
      BigDecimalNum._(_bigDecimal * BigDecimalNum._(other)._bigDecimal);

  BigDecimalNum operator %(num other) {
    final otherDecimal = BigDecimalNum._(other)._bigDecimal;
    final factor = _bigDecimal.divide(
      otherDecimal,
      roundingMode: RoundingMode.HALF_UP,
    );
    final truncatedFactor = factor.withScale(
      0,
      roundingMode:
          factor > BigDecimal.zero ? RoundingMode.DOWN : RoundingMode.UP,
    );

    return BigDecimalNum._(_bigDecimal - (otherDecimal * truncatedFactor));
  }

  double operator /(num other) => _bigDecimal
      .divide(
        BigDecimalNum._(other)._bigDecimal,
        roundingMode: RoundingMode.HALF_UP,
      )
      .toDouble();

  int operator ~/(num other) => BigDecimalNum._(
        _bigDecimal.divide(
          BigDecimalNum._(other)._bigDecimal,
          roundingMode: RoundingMode.HALF_UP,
        ),
      ).truncate();

  BigDecimalNum operator -() => BigDecimalNum._(-_bigDecimal);

  BigDecimalNum remainder(num other) => this - (this ~/ other) * other;

  bool operator <(num other) =>
      _bigDecimal < BigDecimalNum._(other)._bigDecimal;

  bool operator <=(num other) =>
      _bigDecimal <= BigDecimalNum._(other)._bigDecimal;

  bool operator >(num other) =>
      _bigDecimal > BigDecimalNum._(other)._bigDecimal;

  bool operator >=(num other) =>
      _bigDecimal >= BigDecimalNum._(other)._bigDecimal;

  bool get isNaN => false;

  bool get isNegative => _bigDecimal < BigDecimal.zero;

  bool get isInfinite => false;

  bool get isFinite => true;

  BigDecimalNum abs() => BigDecimalNum._bigDecimal(_bigDecimal.abs());

  BigDecimalNum get sign => _bigDecimal > BigDecimal.zero
      ? BigDecimalNum._bigDecimal(BigDecimal.one)
      : _bigDecimal < BigDecimal.zero
          ? BigDecimalNum._bigDecimal(-BigDecimal.one)
          : BigDecimalNum._bigDecimal(BigDecimal.zero);

  int round() => _bigDecimal.toInt(roundingMode: RoundingMode.HALF_UP);

  int floor() => _bigDecimal.toInt(roundingMode: RoundingMode.FLOOR);

  int ceil() => _bigDecimal.toInt(roundingMode: RoundingMode.CEILING);

  int truncate() => _bigDecimal.toInt(roundingMode: RoundingMode.DOWN);

  double roundToDouble() => round().toDouble();

  double floorToDouble() => floor().toDouble();

  double ceilToDouble() => ceil().toDouble();

  double truncateToDouble() => truncate().toDouble();

  BigDecimalNum clamp(num lowerLimit, num upperLimit) {
    final lower = BigDecimalNum._(lowerLimit)._bigDecimal;
    final upper = BigDecimalNum._(upperLimit)._bigDecimal;
    return BigDecimalNum._bigDecimal(
      _bigDecimal.compareTo(lower) < 0
          ? lower
          : _bigDecimal.compareTo(upper) > 0
              ? upper
              : _bigDecimal,
    );
  }

  int toInt() => _bigDecimal.toInt(roundingMode: RoundingMode.DOWN);

  double toDouble() => _bigDecimal.toDouble();

  @override
  bool operator ==(Object other) =>
      _bigDecimal == BigDecimalNum._(other)._bigDecimal;

  @override
  int get hashCode => _bigDecimal.hashCode;

  @override
  String toString() => _bigDecimal.toString();
}
