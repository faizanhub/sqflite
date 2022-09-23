import 'package:flutter/material.dart';
import 'package:sqlite_practise/routes.dart';
import 'package:sqlite_practise/ui/screens/add_student.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SQLite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: AddStudentScreen.routeName,
      onGenerateRoute: CustomRoutes.onGenerateRoute,
    );
  }
}
