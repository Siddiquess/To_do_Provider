import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/snackbars_widget.dart';

Future<void> editData(
  context,
  TextEditingController titelController,
  TextEditingController descriptionController,
  Map? toDo,
) async {
  // Get the data from the form
  if (toDo == null) {
    return;
  }
  final id = toDo['_id'];
  final title = titelController.text;
  final description = descriptionController.text;
  final body = {
    "title": title,
    "description": description,
    "is_completed": false,
  };

  // Submit Updated the data to the server
  final url = "https://api.nstack.in/v1/todos/$id";
  final uri = Uri.parse(url);
  final response = await http.put(
    uri,
    body: jsonEncode(body),
    headers: {'Content-Type': 'application/json'},
  );

  // Show success or fail message based on the status

  if (response.statusCode == 200) {
    titelController.text = '';
    descriptionController.text = '';
    SnackBarWidget.showSuccessMessage('Updation Success', context);
  } else {
    SnackBarWidget.showErrorMessage('Updation Failed', context);
  }
}
