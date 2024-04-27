import 'package:expense_tracker_2024/constants/colors.dart';
import 'package:expense_tracker_2024/navigator/navigator.dart';
import 'package:expense_tracker_2024/view/widgets/add_category_sheet.dart';
import 'package:expense_tracker_2024/view/widgets/categories_list_section.dart';
import 'package:expense_tracker_2024/view/widgets/tab_item.dart';
import 'package:expense_tracker_2024/viewModel/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
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
    CategoryViewModel categoryViewModel = context.watch<CategoryViewModel>();

    return Scaffold(
      backgroundColor: APP_BG_WHITE,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: MAIN_APP_COLOR),
            padding: const EdgeInsets.only(
                top: 50.0, left: 20, right: 20, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    AppNavigator().onNavigatorPop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "All Categories",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FloatingActionButton.small(
                  heroTag: "CategoriesButton",
                  elevation: 2,
                  shape: const CircleBorder(),
                  onPressed: () =>
                      _settingModalBottomSheet(context, categoryViewModel),
                  backgroundColor: MAIN_APP_COLOR_DARK,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10, left: 10),
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
                unselectedLabelColor: Colors.black,
                tabs: const [
                  TabItem(title: 'Income'),
                  TabItem(title: 'Expense')
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: TabBarView(
                controller: _tabController,
                children: [
                  CategoriesListSection(
                    categoryType: 1,
                    categoryViewModel: categoryViewModel,
                  ),
                  CategoriesListSection(
                    categoryType: 0,
                    categoryViewModel: categoryViewModel,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

void _settingModalBottomSheet(
    BuildContext context, CategoryViewModel categoryViewModel) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext bc) {
      return const AddCategorySheet();
    },
  );
}
