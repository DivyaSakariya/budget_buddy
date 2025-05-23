import 'package:flutter/material.dart';

import '../helper/db_helper.dart';
import '../modal/category_modal.dart';

class CategoryController extends ChangeNotifier {
  List<CategoryModal> categoryList = [];

  CategoryController() {
    init();
  }

  init() async {
    categoryList = await DbHelper.dbHelper.getAllCategorys() ?? [];
    notifyListeners();
    return 0;
  }
}
