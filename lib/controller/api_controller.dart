import 'package:flutter/material.dart';

import '../helper/api_helper.dart';

class ApiController extends ChangeNotifier {
  List data = [];

  ApiController() {
    Search();
  }

  Search({
    String val = " ",
  }) async {
    data = await ApiHelper.apiHelper.getWallpapers(
      query: val,
    ) ??
        [];
    notifyListeners();
    return 0;
  }
}
