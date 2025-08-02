import 'package:intl/intl.dart';

class HumanFormats {
  static String humanReadbleNumber(double number) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: "",
      locale: "en",
    ).format(number);

    return formatterNumber;
  }

  static String humanExtentNumber(double number) {
    final formatterNumber = NumberFormat.simpleCurrency(
      decimalDigits: 0,
      // symbol: "",
      locale: "en",
    ).format(number);

    return formatterNumber;
  }
}
