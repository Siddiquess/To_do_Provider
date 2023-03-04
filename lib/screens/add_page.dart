import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/provider/get_datas.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key});

  final TextEditingController titelController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Data'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
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
          Consumer<GetDatas>(builder: (context, getData, child) {
            return ElevatedButton(
              onPressed: () => getData.submitData(
                context,
                titelController,
                descriptionController,
              ),
              child: const Text('Submit'),
            );
          })
        ],
      ),
    );
  }
}
