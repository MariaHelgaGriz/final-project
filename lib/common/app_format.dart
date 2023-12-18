import 'package:intl/intl.dart';

class AppFormat {
  static String currency(double price) {
    return NumberFormat.simpleCurrency(
      name: '\$',
      decimalDigits: 2,
    ).format(price);
  }
}
