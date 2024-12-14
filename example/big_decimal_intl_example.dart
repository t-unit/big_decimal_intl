import 'package:big_decimal/big_decimal.dart';
import 'package:big_decimal_intl/big_decimal_intl.dart';
import 'package:intl/intl.dart';

void main() {
  final formatterEn = BigDecimalFormatter(
    NumberFormat.decimalPatternDigits(locale: 'en-US', decimalDigits: 1),
  );
  final formatterDe = BigDecimalFormatter(
    NumberFormat.decimalPatternDigits(locale: 'de-DE', decimalDigits: 3),
  );

  final bigDecimal = BigDecimal.parse('1000.55555');
  print(formatterEn.format(bigDecimal)); // 1,000.6
  print(formatterDe.format(bigDecimal)); // 1.000,556

  print(formatterEn.parse('1,000.5')); // 1000.5
  print(formatterDe.parse('1.000,556')); // 1000.556
}
