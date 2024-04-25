import 'package:intl/intl.dart';

String numToCurrency(double number, String digits) {
  var formatter = NumberFormat.currency(locale: 'ur_PK', symbol: 'PKR ');
  String pkrText = formatter.format(number);
  return pkrText;
}

extension StringExtensions on String {
  String capitalize() {
    return replaceAll(RegExp(' +'), ' ')
        .split(' ')
        .map((capitalizedString) =>
            capitalizedString.substring(0, 1).toUpperCase() +
            capitalizedString.substring(1))
        .join(' ');
  }
}
