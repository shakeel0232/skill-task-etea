import 'package:flutter_task/controller/db_helper.dart';
import 'package:flutter_task/data_list.dart';

final dbHelper = DatabaseHelper.instance;

class DbController {
  List allData=[];
  var allRows;
  void insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: 'Shakeel',
      DatabaseHelper.columnFatherName: 'Shafiq',
      DatabaseHelper.columnCNIC: 1730149370000,
      DatabaseHelper.columnDOB: '1-jan-1990',
      DatabaseHelper.columnPicture: 'https://via.placeholder.com/150'
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

   query() async {
    // candidateData.clear();
    //  allData.clear();
     allRows = await dbHelper.queryAllRows();
    // allData.addAll(allRows);
    // candidateData.add(allRows);
    print('query all rows:' + allRows.toString());
    // print('query all rows:');
    allRows.forEach(print);
  }
}
