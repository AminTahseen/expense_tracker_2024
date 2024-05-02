import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

String convertDateToReadable(String date) {
  var inputFormat = DateFormat('yyyy-MM-dd');
  var outputFormat = DateFormat('MMMM d, yyyy');

  DateTime parsedDate = inputFormat.parse(date);
  DateTime now = DateTime.now();
  DateTime yesterday = now.subtract(const Duration(days: 1));

  if (parsedDate.year == now.year &&
      parsedDate.month == now.month &&
      parsedDate.day == now.day) {
    return "Performed Today";
  } else if (parsedDate.year == yesterday.year &&
      parsedDate.month == yesterday.month &&
      parsedDate.day == yesterday.day) {
    return "Performed Yesterday";
  } else {
    return 'Performed on ${outputFormat.format(parsedDate)}';
  }
}

Future<String> _getCurrencyLocale() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("currency_locale") ?? "ur_PK";
}

Future<String> _getCurrencySymbol() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("currency_symbol") ?? "PKR ";
}
