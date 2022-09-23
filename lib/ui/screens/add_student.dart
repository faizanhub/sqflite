import 'package:flutter/material.dart';
import 'package:sqlite_practise/core/models/student.dart';
import 'package:sqlite_practise/core/services/db_helper.dart';
import 'package:sqlite_practise/core/utils/utils.dart';
import 'package:sqlite_practise/ui/screens/student_list_screen.dart';
import 'package:sqlite_practise/ui/widgets/custom-textfield.dart';
import 'package:sqlite_practise/ui/widgets/custom_button.dart';

class AddStudentScreen extends StatefulWidget {
  static const String routeName = '/';

  AddStudentScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _nameController = TextEditingController();

  final _courseController = TextEditingController();

  final _mobileController = TextEditingController();

  final _totalFeeController = TextEditingController();

  final _feePaidController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  handleSaveButton() async {
    if (_formKey.currentState!.validate()) {
      ///save record in database
      Student student = Student(
        name: _nameController.text.trim(),
        course: _courseController.text.trim(),
        mobile: _mobileController.text.trim(),
        totalFee: int.parse(_totalFeeController.text.trim()),
        feePaid: int.parse(_feePaidController.text.trim()),
      );

      int result = await DatabaseHelper.instance.insertStudent(student);

      if (result > 0) {
        Utils.showFlushBar(context, 'Success', 'Record added');
      } else {
        Utils.showFlushBar(context, 'Error', 'Record not added');
      }
    }
  }

  handleViewAllBtn() {
    Navigator.pushNamed(context, StudentListScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _nameController,
                  hintText: 'Name',
                  labelText: 'Name',
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return 'Name field cannot be empty';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: _courseController,
                  hintText: 'Course',
                  labelText: 'Course',
                  validator: (course) {
                    if (course == null || course.isEmpty) {
                      return 'Course field cannot be empty';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: _mobileController,
                  hintText: 'Mobile',
                  labelText: 'Mobile',
                  validator: (mobile) {
                    if (mobile == null || mobile.isEmpty) {
                      return 'Mobile field cannot be empty';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  controller: _totalFeeController,
                  hintText: 'Total Fee',
                  labelText: 'Total Fee',
                  validator: (fee) {
                    if (fee == null || fee.isEmpty) {
                      return 'Total Fee field cannot be empty';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  controller: _feePaidController,
                  hintText: 'Fee Paid',
                  labelText: 'Fee Paid',
                  validator: (feePaid) {
                    if (feePaid == null || feePaid.isEmpty) {
                      return 'FeePaid field cannot be empty';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                ),
                CustomButton(
                  onPressed: handleSaveButton,
                  title: 'Save',
                ),
                const SizedBox(height: 20),
                CustomButton(
                  onPressed: handleViewAllBtn,
                  title: 'View All',
                  backgroundColor: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
