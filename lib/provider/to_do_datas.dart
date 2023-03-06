import 'package:flutter/material.dart';

class ToDoDatas with ChangeNotifier {
  List<dynamic> _items = [];
  List<dynamic> get items => _items;
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  getdatas(List<dynamic> result) {
    _items = result;
    _isLoading = false;
    notifyListeners();
  }

  deleteData(filtered) {
    _items = filtered;
    notifyListeners();
  }

  loadData() {
    _isLoading = true;
    notifyListeners();
  }
}
