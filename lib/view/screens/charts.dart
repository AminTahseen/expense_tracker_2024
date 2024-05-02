import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/helpers/helpers.dart';
import 'package:expense_tracker_2024/model/UIObjects/bar_data.dart';
import 'package:expense_tracker_2024/model/category_model.dart';
import 'package:expense_tracker_2024/model/transaction_model.dart';
import 'package:expense_tracker_2024/view/widgets/category_item.dart';
import 'package:expense_tracker_2024/view/widgets/tab_item.dart';
import 'package:expense_tracker_2024/viewModel/charts_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

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
    final ChartsViewModel chartsViewModel = context.watch<ChartsViewModel>();
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
              "Statistics",
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
                  BorderSide(
                    color: Color.fromARGB(188, 158, 158, 158),
                    width: 1,
                  ),
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
              children: [
                ChartSection(
                  chartType: 1,
                  viewModel: chartsViewModel,
                ),
                ChartSection(
                  chartType: 0,
                  viewModel: chartsViewModel,
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
  final ChartsViewModel viewModel;
  const ChartSection(
      {super.key, required this.chartType, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            height: MediaQuery.of(context).size.height * 0.4,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      margin: const EdgeInsets.only(bottom: 5),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      child: const BarChartIncomeExpense(
                        summary: [20.0, 30.0, 40.0, 50.0, 60.0],
                      ),
                    ),
                    Text(
                      chartType == 1
                          ? "Top 5 Income Breakdown"
                          : "Top 5 Expense Breakdown",
                      style: GoogleFonts.lato(
                        color: TEXT_GREY_DARK,
                      ),
                    )
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0a0a0a).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "In Development",
                      style: GoogleFonts.lato(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
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
          ValueListenableBuilder<Box<CategoryModel>>(
            valueListenable: viewModel.getCategories().listenable(),
            builder: (context, box, _) {
              var data = box.values.toList().cast<CategoryModel>();
              var data2 = data
                  .where((element) => element.categoryType == chartType)
                  .toList()
                  .cast<CategoryModel>();
              var transactionList = viewModel
                  .getTransactions()
                  .values
                  .toList()
                  .where((element) => element.transactionType == chartType)
                  .toList();
              return GenerateCategoriesList(
                list: data2,
                transactionList: transactionList,
              );
            },
          )
        ],
      ),
    );
  }
}

class GenerateCategoriesList extends StatelessWidget {
  final List<CategoryModel> list;
  final List<TransactionModel> transactionList;

  const GenerateCategoriesList({
    super.key,
    required this.list,
    required this.transactionList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 10.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 35.0,
          maxHeight: MediaQuery.of(context).size.height * 0.3,
        ),
        child: Scrollbar(
          trackVisibility: true,
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, color: Colors.black12),
            padding: const EdgeInsets.all(0.0),
            // Let the ListView know how many items it needs to build.
            itemCount: list.length,
            itemBuilder: (context, index) {
              double sum = transactionList
                  .where(
                      (element) => element.categoryId == list[index].categoryId)
                  .toList()
                  .fold(
                      0, (previousValue, item) => previousValue + item.amount);
              return ChartCategoryItem(
                item: list[index],
                totalCategorySpent: sum,
              );
            },
          ),
        ),
      ),
    );
  }
}

class ChartCategoryItem extends StatelessWidget {
  final CategoryModel item;
  final double totalCategorySpent;
  const ChartCategoryItem(
      {super.key, required this.item, required this.totalCategorySpent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.categoryName,
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: MAIN_APP_COLOR_DARK,
            ),
          ),
          Text(
            numToCurrency(totalCategorySpent, "0"),
            style: GoogleFonts.lato(
              color: MAIN_APP_COLOR,
            ),
          )
        ],
      ),
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
                      color: MAIN_APP_COLOR_DARK,
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
