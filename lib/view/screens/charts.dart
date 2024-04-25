import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/model/UIObjects/bar_data.dart';
import 'package:expense_tracker_2024/view/widgets/spacing.dart';
import 'package:expense_tracker_2024/view/widgets/tab_item.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({super.key});

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_BG_WHITE,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: MAIN_APP_COLOR),
            padding: const EdgeInsets.only(
                top: 50.0, left: 20, right: 20, bottom: 10.0),
            child: Text(
              "Charts",
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white54,
                border: Border.fromBorderSide(
                  BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: MAIN_APP_COLOR_DARK,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey.shade900,
                tabs: const [
                  TabItem(title: 'Income'),
                  TabItem(title: 'Expense')
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ChartSection(
                  chartType: 0,
                ),
                ChartSection(
                  chartType: 1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChartSection extends StatelessWidget {
  final int chartType;
  const ChartSection({super.key, required this.chartType});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          width: MediaQuery.of(context).size.width,
          margin:
              const EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 20),
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          height: 310,
          child: Column(
            children: [
              const SizedBox(
                height: 250,
                child: BarChartIncomeExpense(
                  summary: [10.40, 20.50, 42.50, 90.30, 60.40],
                ),
              ),
              const AddSpacing(),
              Text(
                chartType == 0 ? "Income Breakdown" : "Expense Breakdown",
                style: GoogleFonts.lato(
                  color: TEXT_GREY_DARK,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20.0),
          child: Text(
            "Categories",
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: TEXT_GREY_DARK,
            ),
          ),
        ),
      ],
    );
  }
}

class BarChartIncomeExpense extends StatelessWidget {
  final List summary;
  const BarChartIncomeExpense({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      catg1Amount: summary[0],
      catg2Amount: summary[1],
      catg3Amount: summary[2],
      catg4Amount: summary[3],
      catg5Amount: summary[4],
    );
    myBarData.initializeBarData();
    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                      toY: data.y,
                      color: MAIN_APP_COLOR,
                      width: 12,
                      borderRadius: BorderRadius.circular(5))
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
