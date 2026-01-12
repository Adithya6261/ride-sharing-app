import 'package:intl/intl.dart';

class CurrencyUtils {
  static final _formatter = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

  static String format(double amount) {
    return _formatter.format(amount);
  }
}
