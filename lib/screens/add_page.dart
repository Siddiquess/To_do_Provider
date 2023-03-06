import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/functions/edit_data.dart';
import 'package:to_do_app/provider/to_do_datas.dart';

import '../functions/submit_data.dart';

class AddPage extends StatelessWidget {
  final Map? toDo;
  final bool isEdit;
  AddPage({
    super.key,
    this.toDo,
    this.isEdit = false,
  });

  final TextEditingController titelController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final item = toDo;
    if (item != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        final title = item['title'];
        final discription = item['description'];
        titelController.text = title ?? '';
        descriptionController.text = discription ?? '';
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Data' : 'Add Data'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titelController,
            decoration: const InputDecoration(
              hintText: 'Title',
            ),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
            minLines: 5,
            maxLines: 8,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(
            height: 40,
          ),
          Consumer<ToDoDatas>(builder: (context, getData, child) {
            return ElevatedButton(
              onPressed: () {
                isEdit
                    ? editData(
                        context,
                        titelController,
                        descriptionController,
                        toDo,
                      )
                    : submitData(
                        context,
                        titelController,
                        descriptionController,
                      );
              },
              child: Text(isEdit ? 'Update' : 'Submit'),
            );
          })
        ],
      ),
    );
  }
}
