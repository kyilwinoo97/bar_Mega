import 'dart:io';

import 'package:bar_mega/model/Unit.dart';
import 'package:bar_mega/repository/MainRepository.dart';
import 'package:bar_mega/widgets/Dialogs.dart';
import 'package:bar_mega/widgets/Toasts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../injection_container.dart';


class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingState();
}

class _SettingState extends State<Settings> {
 
  String selectedItem;
  List<String> itemList =["Printer Settings","Log Out"];
  TextEditingController controller = TextEditingController();
  MainRepository repository;
  @override
  void initState() {
    repository = sl<MainRepository>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Row(
        children :[
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
              children: [
                CategoryWidget(label: itemList[0],onSelected: (selected){
                  if(selected){
                    setState(() {
                      selectedItem = itemList[0];
                      generatePdf();
                    });
                  }
                }),
                CategoryWidget(label: itemList[1],onSelected: (selected){
                  if(selected){
                    setState(() {
                      selectedItem = itemList[1];

                    });
                  }
                }),
              ],
        ),
            ),
          ),
          VerticalDivider(
            width: 0.5,
            color: Colors.black,
          ),
          Expanded(
            flex: 7,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: TextFormField(
                        controller: controller,
                      ),
                      // child: PdfPreview(
                      //   maxPageWidth: mQuery.width * 0.6,
                      // build: (format) => doc.save(),
                      // ),
                    ),

                  ],
                ),
              ),
          )
      ]
      ),
    );
  }
  addUnit(String value) async {
    var result = await repository.addUnit(Unit(name: value));
    if(result > -1){
      Toasts.greenToast("Success");
    }
  }
  CategoryWidget({String label, Function(bool) onSelected}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: ChoiceChip(
        key: Key(label),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.green, width: 1.5),
          borderRadius: BorderRadius.circular(50.0),
        ),
        selectedColor: Colors.green,
        backgroundColor: Colors.green.shade50,
        padding: const EdgeInsets.all(16.0),
        label: SizedBox(
          width: double.infinity,
          child: Text(
            label,
            style: TextStyle(
                color: Colors.green,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        selected: false,
        onSelected: onSelected,
      ),
    );
  }

  void generatePdf() async{
    const double inch = 72.0;
    const double cm = inch / 2.54;
    final doc = pw.Document(pageMode: PdfPageMode.fullscreen,title: "Hello",deflate: zlib.encode);
    doc.addPage(pw.Page(
      theme: pw.ThemeData.withFont(
        base: pw.Font.ttf(await rootBundle.load("assets/font/NotoSerifMyanmar_Regular.ttf")),
        bold:  pw.Font.ttf(await rootBundle.load("assets/font/NotoSerifMyanmar_Regular.ttf")),
      ),
        pageFormat: PdfPageFormat.roll80.copyWith(height: 20 * cm),
        build: (pw.Context context) {
        return  pw.Center(
              child: pw.Column(
                  children: [
                    pw.Text("ြကက်သား ‌ေြကာ်"),
                  ]
              )
        );
        }));
    await Printing.layoutPdf(onLayout: (format) => doc.save());

  }

}

