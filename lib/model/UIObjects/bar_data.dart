import 'package:expense_tracker_2024/model/UIObjects/individual_bar.dart';

class BarData {
  final double catg1Amount;
  final double catg2Amount;
  final double catg3Amount;
  final double catg4Amount;
  final double catg5Amount;

  BarData({
    required this.catg1Amount,
    required this.catg2Amount,
    required this.catg3Amount,
    required this.catg4Amount,
    required this.catg5Amount,
  });
  List<IndividiualBar> barData = [];
  void initializeBarData() {
    barData = [
      IndividiualBar(x: 0, y: catg1Amount),
      IndividiualBar(x: 1, y: catg2Amount),
      IndividiualBar(x: 2, y: catg3Amount),
      IndividiualBar(x: 3, y: catg4Amount),
      IndividiualBar(x: 4, y: catg5Amount),
    ];
  }
}
