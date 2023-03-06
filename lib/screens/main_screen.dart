import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../functions/delete_data.dart';
import '../functions/fetch_data.dart';
import '../functions/navigation.dart';
import '../provider/to_do_datas.dart';

class ScreenMain extends StatelessWidget {
  const ScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        fetchTodoData(context);
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
      ),
      body: Consumer<ToDoDatas>(
        builder: (context, getData, child) {
          return Visibility(
            visible: getData.isLoading,
            replacement: RefreshIndicator(
              onRefresh: () => fetchTodoData(context),
              child: ListView.builder(
                itemCount: getData.items.length,
                itemBuilder: (context, index) {
                  final items = getData.items;
                  final item = items[index] as Map;
                  final id = item['_id'] as String;
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text(item['title']),
                    subtitle: Text(item['description']),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'Edit') {
                          // edit the item and show the changes
                          Navigate.pageRoutToDoEditData(context,item);
                        } else if (value == 'Delete') {
                          // Delete the item and remove from the srcreen
                          deleteById(id, getData, context);
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                            value: 'Edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem(
                            value: 'Delete',
                            child: Text('Delete'),
                          ),
                        ];
                      },
                    ),
                  );
                },
              ),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigate.pageRoutToDoAddData(context);
        },
        label: const Text('Add Data'),
      ),
    );
  }
}
