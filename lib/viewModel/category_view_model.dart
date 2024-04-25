import 'package:expense_tracker_2024/model/category_model.dart';
import 'package:expense_tracker_2024/repositoryImpl/local/category_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class CategoryViewModel extends ChangeNotifier {
  final categoryRepo = CategoryRepoImpl();

  String _message = "";
  String get message => _message;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  int _selectedTransactionType = 1;
  int get selectedTransactionType => _selectedTransactionType;

  setSelectedTransactionType(int type) {
    _selectedTransactionType = type;
    notifyListeners();
  }

  setMessage(String message) async {
    _message = message;
    notifyListeners();
  }

  setErrorMessage(String message) async {
    _errorMessage = message;
    notifyListeners();
  }

  Box<CategoryModel> getCategories() {
    return categoryRepo.getData();
  }

  createCategory(String categoryName) async {
    if (_validate(categoryName)) {
      var uuid = const Uuid();
      var categoryId = uuid.v1();
      setErrorMessage("");
      final categoryModel = CategoryModel(
        categoryId: categoryId,
        categoryName: categoryName,
        createdByUserId: 1,
        categoryType: selectedTransactionType,
      );
      categoryRepo.insert(categoryModel);
      setMessage("Category Created Successfully");
      clearMessage();
    }
  }

  clearMessage() {
    Future.delayed(const Duration(seconds: 2), () {
      setErrorMessage("");
      setMessage("");
    });
  }

  bool _validate(String categoryName) {
    if (categoryName.isEmpty) {
      setErrorMessage("A category name is required");
      return false;
    }
    return true;
  }
}
