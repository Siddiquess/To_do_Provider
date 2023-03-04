import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/screens/add_page.dart';
import '../provider/get_datas.dart';

class ScreenMain extends StatelessWidget {
  const ScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<GetDatas>(context, listen: false).fetchTodo(context);
        print('=========================');
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
      ),
      body: Consumer<GetDatas>(
        builder: (context, getData, child){
          return ListView.builder(
            itemCount:getData.items.length,
            itemBuilder: (context, index) {
              final items = getData.items;
              final item = items[index] as Map;
              return  ListTile(
                title: Text(item['title']),
                subtitle: Text(item['description']),
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _pageRoutToDoAddData(context);
        },
        label: const Text('Add Data'),
      ),
    );
  }

  void _pageRoutToDoAddData(context) {
    final route = MaterialPageRoute(
      builder: (context) => AddPage(),
    );
    Navigator.push(context, route);
  }

  // Future<void> fetchTodo(context) async {
  //   const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
  //   final uri = Uri.parse(url);
  //   final response = await http.get(uri);

  //   if (response.statusCode == 200) {
  //     final json = jsonDecode(response.body) as Map;
  //     final result = json['items'] as List;
  //     Provider.of<GetDatas>(context, listen: false).getdatas(result);
  //   } else {
  //     print('it is error =================');
  //   }
  // }
}
