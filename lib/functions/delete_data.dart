import 'package:to_do_app/widgets/snackbars_widget.dart';

import '../provider/to_do_datas.dart';
import 'package:http/http.dart' as http;

Future<void> deleteById(String id, ToDoDatas getData, context) async {
  // Delete the item
  final url = 'https://api.nstack.in/v1/todos/$id';
  final uri = Uri.parse(url);
  final response = await http.delete(uri);

  if (response.statusCode == 200) {
    // Remove the item from the screen
    final filtered =
        getData.items.where((element) => element['_id'] != id).toList();
    getData.deleteData(filtered);
    SnackBarWidget.showSuccessMessage("Deleted Successfully", context);
  } else {
    // show error
    SnackBarWidget.showErrorMessage('Deletation Failed', context);
  }
}
