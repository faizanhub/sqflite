import 'package:flutter/material.dart';
import 'package:sqlite_practise/core/models/student.dart';
import 'package:sqlite_practise/ui/screens/add_student.dart';
import 'package:sqlite_practise/ui/screens/student_list_screen.dart';
import 'package:sqlite_practise/ui/screens/update_student_screen.dart';

class CustomRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AddStudentScreen.routeName:
        return MaterialPageRoute(builder: (_) => AddStudentScreen());

      case StudentListScreen.routeName:
        return MaterialPageRoute(builder: (_) => StudentListScreen());

      case UpdateStudentScreen.routeName:
        final args = settings.arguments as Student;
        return MaterialPageRoute(
            builder: (_) => UpdateStudentScreen(
                  student: args,
                ));

      default:
        return MaterialPageRoute(builder: (_) => AddStudentScreen());
    }
  }
}
