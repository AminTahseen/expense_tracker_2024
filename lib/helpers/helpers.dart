import 'package:intl/intl.dart';

String numToCurrency(double number, String digits) {
  var formatter = NumberFormat.currency(locale: 'ur_PK', symbol: 'PKR ');
  String pkrText = formatter.format(number);
  return pkrText;
}
