import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/functions/fetch_data.dart';
import 'package:to_do_app/provider/to_do_datas.dart';
import '../screens/add_page.dart';

class Navigate {
  static Future<void> pageRoutToDoAddData(context) async {
    final route = MaterialPageRoute(
      builder: (context) => AddPage(),
    );
    await Navigator.push(context, route);
    Provider.of<ToDoDatas>(context, listen: false).loadData();
    fetchTodoData(context);
  }

  static Future<void> pageRoutToDoEditData(context, Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddPage(
        toDo: item,
        isEdit: true,
      ),
    );
   
    await Navigator.push(context, route);
    
    // Provider.of<ToDoDatas>(context, listen: false).loadData();
    //  await fetchTodoData(context);
  }
}
