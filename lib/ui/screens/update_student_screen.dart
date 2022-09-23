import 'package:flutter/material.dart';
import 'package:sqlite_practise/core/models/student.dart';
import 'package:sqlite_practise/core/services/db_helper.dart';
import 'package:sqlite_practise/core/utils/utils.dart';
import 'package:sqlite_practise/ui/screens/student_list_screen.dart';
import 'package:sqlite_practise/ui/widgets/custom-textfield.dart';
import 'package:sqlite_practise/ui/widgets/custom_button.dart';

class UpdateStudentScreen extends StatefulWidget {
  static const String routeName = '/update_student_screen';

  final Student student;

  UpdateStudentScreen({Key? key, required this.student}) : super(key: key);

  @override
  State<UpdateStudentScreen> createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
  final _nameController = TextEditingController();
  final _courseController = TextEditingController();
  final _mobileController = TextEditingController();
  final _totalFeeController = TextEditingController();
  final _feePaidController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  updateStudentBtn() async {
    if (_formKey.currentState!.validate()) {
      ///update record in database

      final Student student = Student(
        id: widget.student.id,
        name: _nameController.text,
        course: _courseController.text,
        mobile: _mobileController.text,
        totalFee: int.parse(_totalFeeController.text),
        feePaid: int.parse(_feePaidController.text),
      );

      DatabaseHelper.instance.updateStudentById(student).then((result) {
        print('result is $result');
        if (result > 0) {
          Utils.showFlushBar(context, 'Success', 'Record Updated');
        } else {
          Utils.showFlushBar(
              context, 'Failed', 'Record not updated due to some reason');
        }
      });

      // int result = await DatabaseHelper.instance.updateStudentById(student);
      // print('deleted or not resutl $result');

      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    _nameController.text = widget.student.name;
    _courseController.text = widget.student.course;
    _mobileController.text = widget.student.mobile;
    _totalFeeController.text = widget.student.totalFee.toString();
    _feePaidController.text = widget.student.feePaid.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('id is ${widget.student.id}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                  onPressed: () {
                    updateStudentBtn();
                  },
                  title: 'Update',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
