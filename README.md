# Big Decimal Intl

This package allows using `NumberFormat` of the `intl` package together with `BigDecimal` numbers.

## Usage

First define a number format wrapped inside a `BigDecimalFormatter` object:

```dart
  final formatter = BigDecimalFormatter(NumberFormat.decimalPattern());
```

To format a number into at `String` us the `format` method:

```dart
  final formatted = formatter.format(BigDecimal.parse('1.5'));
```

To parse a number from a `String` use the `parse` method:

```dart
  final bigDecimal = formatter.parse('1.5');
```

## Additional information

This package is a port of the intl part of [dart-decimal](https://github.com/a14n/dart-decimal/blob/master/lib/intl.dart) for [BigDecimal](https://github.com/bugless/big-decimal).
