import 'package:big_decimal/big_decimal.dart';
import 'package:intl/intl.dart';

class DartDecimalParser extends NumberParserBase<BigDecimal> {
  DartDecimalParser(super.format, super.text);

  @override
  BigDecimal fromNormalized(String normalizedText) =>
      BigDecimal.parse(normalizedText);

  @override
  BigDecimal nan() => throw FormatException('Could not parse BigDecimal');

  @override
  BigDecimal negativeInfinity() =>
      throw FormatException('Could not parse BigDecimal');

  @override
  BigDecimal positiveInfinity() =>
      throw FormatException('Could not parse BigDecimal');

  @override
  BigDecimal scaled(BigDecimal parsed, int scale) =>
      (parsed.divide(BigDecimal.fromBigInt(BigInt.from(scale))));
}
