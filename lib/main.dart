import 'package:flutter/material.dart';
import 'package:hive_secured/screen/home_page.dart';
import 'package:hive_secured/service/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hive.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Secured',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
