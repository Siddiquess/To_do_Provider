import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../provider/to_do_datas.dart';

Future<void> fetchTodoData(context) async {
  const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
  final uri = Uri.parse(url);
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body) as Map;
    final result = json['items'] as List;
    Provider.of<ToDoDatas>(context, listen: false).getdatas(result);
  } else {
    const  Text('Error found');
  }
}
