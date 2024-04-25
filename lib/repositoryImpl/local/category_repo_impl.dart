import 'package:expense_tracker_2024/constants/constants.dart';
import 'package:expense_tracker_2024/model/category_model.dart';
import 'package:expense_tracker_2024/repository/category_repo.dart';
import 'package:hive/hive.dart';

class CategoryRepoImpl extends CategoryRepo {
  final _categoryBox = Hive.box<CategoryModel>(HIVE_CATEGORY_BOX_NAME);

  @override
  Box<CategoryModel> getData() {
    return _categoryBox;
  }

  @override
  insert(CategoryModel model) {
    _categoryBox.add(model);
    model.save();
  }
}
