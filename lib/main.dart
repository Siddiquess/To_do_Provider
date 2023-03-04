import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/provider/get_datas.dart';
import 'package:to_do_app/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GetDatas(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'To do app',
          theme: ThemeData.dark(),
          home: const ScreenMain()),
    );
  }
}
