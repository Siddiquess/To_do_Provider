import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/snackbars_widget.dart';

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
      SnackBarWidget.showSuccessMessage('Creation Success', context);
    } else {
      SnackBarWidget.showErrorMessage('Creation Failed', context);
    }
  }