import 'package:flutter/material.dart';
import 'package:flutter_task/controller/db_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

TextEditingController nameController = TextEditingController();
TextEditingController fNameController = TextEditingController();
TextEditingController cnicController = TextEditingController();
TextEditingController dobController = TextEditingController();
final dbHelper = DatabaseHelper.instance;

class MyInsertForm extends StatefulWidget {
  const MyInsertForm({Key? key}) : super(key: key);

  @override
  State<MyInsertForm> createState() => _MyInsertFormState();
}

class _MyInsertFormState extends State<MyInsertForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      hintText: 'Name', labelText: 'Name *')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: fNameController,
                  decoration: const InputDecoration(
                      hintText: 'Father Name', labelText: 'Father Name *')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  keyboardType: TextInputType.number,
                  controller: cnicController,

                  decoration: const InputDecoration(
                      hintText: 'CNIC', labelText: 'CNIC *')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                  controller: dobController,
                  decoration: const InputDecoration(
                      hintText: 'DOB', labelText: 'DOB *')),
            ), Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () {
                if (nameController.text.isNotEmpty &&
                    fNameController.text.isNotEmpty &&
                    cnicController.text.isNotEmpty &&
                    dobController.text.isNotEmpty){
                  insert();
                }else{
                  Fluttertoast.showToast(
                      msg: "Fields can not be empty",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                  print('Fields can not be empty');
                  // Toast("Toast plugin app", duration: Toast.lengthShort, gravity:  Toast.bottom);
                }

              }, child: Text('Save Data'),),
            ),
          ],
        ),
      ),
    );
  }
}

void insert() async {
  // row to insert
  Map<String, dynamic> row = {
    DatabaseHelper.columnName: nameController.text.toString(),
    DatabaseHelper.columnFatherName: fNameController.text.toString(),
    DatabaseHelper.columnCNIC: cnicController.text.toString(),
    DatabaseHelper.columnDOB: dobController.text.toString(),
    DatabaseHelper.columnPicture: 'https://via.placeholder.com/150'
  };
  final id = await dbHelper.insert(row);
  print('inserted row id: $id');
}
