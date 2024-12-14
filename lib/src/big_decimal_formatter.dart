import 'package:big_decimal/big_decimal.dart';
import 'package:big_decimal_intl/src/big_decimal_num.dart';
import 'package:big_decimal_intl/src/big_decimal_parser.dart';
import 'package:intl/intl.dart';

class BigDecimalFormatter {
  BigDecimalFormatter(this.numberFormat);

  final NumberFormat numberFormat;

  /// Parses [text] as a decimal literal using the provided number formatter
  /// and returns its value as [BigDecimal]
  BigDecimal parse(String text) => DartDecimalParser(numberFormat, text).value!;

  /// Parses [text] as a decimal literal using the provided number formatter
  /// and returns its value as [BigDecimal], or null if the parsing fails.
  BigDecimal? tryParse(String text) {
    try {
      return parse(text);
    } on FormatException {
      return null;
    }
  }

  /// Format [number] according to our pattern and return the formatted string.
  String format(BigDecimal number) =>
      numberFormat.format(BigDecimalNum(number));
}
