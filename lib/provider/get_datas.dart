import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetDatas with ChangeNotifier {
  List<dynamic> _items = [];
  List<dynamic> get items => _items;

  getdatas(List<dynamic> result) {
    _items = result;
    notifyListeners();
  }

  Future<void> fetchTodo(context) async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;

      getdatas(result);
     
    } else {
      print('it is error =================');
    }
    notifyListeners();
  }

  Future<void> submitData(
    context,
    TextEditingController titelController,
    TextEditingController descriptionController,
  ) async {
    // Get the data from the form
    final title = titelController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };

    // Submit the data to the server
    const url = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    // Show success or fail message based on the status

    if (response.statusCode == 201) {
      titelController.text = '';
      descriptionController.text = '';
      showSuccessMessage('Creation Success', context);
    } else {
      showErrorMessage('Creation Failed', context);
      print(response.statusCode);
    }
    notifyListeners();
  }

  void showSuccessMessage(String message, context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message, context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
