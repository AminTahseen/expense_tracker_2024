import 'package:expense_tracker_2024/model/category_model.dart';
import 'package:expense_tracker_2024/view/widgets/category_item.dart';
import 'package:expense_tracker_2024/view/widgets/no_data_available.dart';
import 'package:expense_tracker_2024/viewModel/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class CategoriesListSection extends StatelessWidget {
  final int categoryType;
  final CategoryViewModel categoryViewModel;
  const CategoriesListSection({
    super.key,
    required this.categoryType,
    required this.categoryViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<CategoryModel>>(
      valueListenable: categoryViewModel.getCategories().listenable(),
      builder: (context, box, _) {
        var data2 = box.values
            .where((element) => element.categoryType == categoryType)
            .toList()
            .cast<CategoryModel>();
        var data = data2.reversed.toList().cast<CategoryModel>();

        return data.isNotEmpty
            ? CategoryList(data: data)
            : const NoDataAvailable(message: "No Categories Available");
      },
    );
  }
}

class CategoryList extends StatelessWidget {
  final List<CategoryModel> data;

  const CategoryList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return CategoryItem(
          categoryName: data[index].categoryName,
          categoryId: data[index].categoryId,
        );
      },
    );
  }
}
