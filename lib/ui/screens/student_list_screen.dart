import 'package:flutter/material.dart';
import 'package:sqlite_practise/core/models/student.dart';
import 'package:sqlite_practise/core/services/db_helper.dart';
import 'package:sqlite_practise/core/utils/utils.dart';
import 'package:sqlite_practise/ui/screens/update_student_screen.dart';
import 'package:sqlite_practise/ui/widgets/custom_button.dart';

class StudentListScreen extends StatefulWidget {
  static const String routeName = '/student_list_screen';

  const StudentListScreen({Key? key}) : super(key: key);

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  handleDeleteBtn(Student student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text('Are you sure to delete?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No')),
            TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await deleteUser(student.id!);

                  setState(() {});
                },
                child: const Text('Yes'))
          ],
        );
      },
    );
  }

  deleteUser(int id) async {
    int result = await DatabaseHelper.instance.deleteStudentById(id);
    if (result > 0) {
      if (mounted) {
        Utils.showFlushBar(context, 'Success', 'Record Deleted Successfully');
      }
    } else {
      if (mounted) {
        Utils.showFlushBar(context, 'Error', 'Record Not Added');
      }
    }
  }

  handleUpdateBtn(Student student) {
    Navigator.pushNamed(context, UpdateStudentScreen.routeName,
        arguments: student);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List Screen'),
      ),
      body: FutureBuilder<List<Student>>(
        future: DatabaseHelper.instance.getAllStudent(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Some Error occurred ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(child: Text('No Data yet...'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final Student student = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Id'),
                                Text('Name'),
                                Text('Course'),
                                Text('Mobile'),
                                Text('Total Fee'),
                                Text('Fee Paid'),
                              ],
                            ),
                            const SizedBox(width: 40),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(student.id.toString()),
                                Text(student.name),
                                Text(student.course),
                                Text(student.mobile),
                                Text(student.totalFee.toString()),
                                Text(student.feePaid.toString()),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                onPressed: () {
                                  handleDeleteBtn(student);
                                },
                                title: 'Delete',
                                backgroundColor: Colors.red,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CustomButton(
                                onPressed: () {
                                  handleUpdateBtn(student);
                                },
                                title: 'Update',
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
