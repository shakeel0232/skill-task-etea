import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_task/controller/controller.dart';
import 'package:flutter_task/data_list.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:http/http.dart' show get;
class DisplayData extends StatefulWidget {
  var data;

  DisplayData({Key? key, this.data}) : super(key: key);

  @override
  State<DisplayData> createState() => _DisplayDataState();
}

var allRows;

class _DisplayDataState extends State<DisplayData> {
  // DbController dbController=DbController();
  // List? l;
  @override
  void initState() {
    query().then((res) {
      // allRows
    });

    // .then((res){
    print('aaaa: ' + allRows.toString());
    // });
    // print(dbController.allData!.length.toString());
    // l=dbController.query();
// print(l!.length.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task')),
      body: ListView.builder(
          itemCount: allRows.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  _createPDF(allRows, index);
                },
                leading: Image.network(allRows[index]['picture'].toString()),
                title: Text(allRows[index]['name'].toString()),
                subtitle: Text(allRows[index]['fatherName'].toString() +
                    '\n' +
                    allRows[index]['cnic'].toString()),
                trailing: Text(allRows[index]['dob'].toString()),
              ),
            );
          }),
    );
  }
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

Future<void> _createPDF(data, index) async {
  var url = data[index]['picture'];
  var response = await get(Uri.parse(url));
  var img = response.bodyBytes;


  //Create a new PDF document
  PdfDocument document = PdfDocument();
  var pages = document.pages.add();

  //Add a new page and draw text
  pages.graphics.drawString(
      data[index]['name'], PdfStandardFont(PdfFontFamily.helvetica, 20),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      bounds: Rect.fromLTRB(10, 10, 10, 0));
  pages.graphics.drawString(
      data[index]['fatherName'], PdfStandardFont(PdfFontFamily.helvetica, 20),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      bounds: Rect.fromLTRB(10, 30, 10, 0));
  pages.graphics.drawString(
      data[index]['cnic'], PdfStandardFont(PdfFontFamily.helvetica, 20),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      bounds: Rect.fromLTRB(10, 50, 10, 0));

  pages.graphics.drawString(
      data[index]['dob'], PdfStandardFont(PdfFontFamily.helvetica, 20),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      bounds: Rect.fromLTRB(10, 70, 10, 0));





  //Create a bitmap object.
  PdfBitmap image = PdfBitmap(img);



  pages.graphics.drawImage(image,
      Rect.fromLTRB(10, 120, 10, 0));


  //Save the document
  List<int> bytes = document.save();
  openPdf(bytes);
  //Dispose the document
  document.dispose();
}

openPdf(bytes) async {
  //Get external storage directory
  Directory directory = (await getApplicationDocumentsDirectory());
//Get directory path
  String path = directory.path;
//Create an empty file to write PDF data
  File file = File('$path/Output.pdf');
//Write PDF data
  await file.writeAsBytes(bytes, flush: true);
//Open the PDF document in mobile
  OpenFile.open('$path/Output.pdf');
}
