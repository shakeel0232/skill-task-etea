import 'package:flutter/material.dart';
import 'package:flutter_task/controller/controller.dart';
import 'package:flutter_task/controller/db_helper.dart';
import 'package:flutter_task/data_list.dart';
import 'package:flutter_task/model/candidate.dart';
import 'package:flutter_task/view/display_data.dart';
import 'package:flutter_task/view/insert_form.dart';

class MyHomePage extends StatelessWidget {
  DbController dbController = DbController();

  // reference to our single class that manages the database

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sqflite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text(
                'insert',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>  MyInsertForm()),);
                // dbController.insert();
              },
            ),
            ElevatedButton(
              child: Text(
                'query',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: ()  {
                // var data;
                // dbController.query().then((res){
                //   // print(res.toString());
                //   data=res;
                // });
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>  DisplayData()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

// Button onPressed methods

}
