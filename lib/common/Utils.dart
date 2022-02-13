import 'package:bar_mega/widgets/ListItem.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart' as intl;

class Utils{
  static Utils _instance;
  Utils._internal(){
    _instance = this;
  }
  factory Utils() => _instance ?? Utils._internal();
static const String All ="All";
static const String MainMenu ="Main Menu";
static const String SoftDrink ="Soft Drink";
static const String AlcoholicDrink ="Alcoholic Drink";
static const String Desserts ="Desserts";
static const List<String> categoryList = [All,MainMenu,SoftDrink,AlcoholicDrink,Desserts];


static const String dish ="ပွဲ";
static const String bottle ="ပုလင်း";
static const String cup ="ခွက်";
static const List<String> unitList = ['ခု','လုံး','ဘူး',dish,bottle,cup];

  static const kDateTimePickerTheme = DatePickerTheme(
    cancelStyle: TextStyle(
      color: Colors.red,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    doneStyle: TextStyle(
      color: Colors.grey,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );

  static List<ListItem<BluetoothDevice>> lstDevices = [];


  static bool validatePhone(String phone) {
    final regex = new RegExp(r"^(09|\+?950?9|\+?95950?9)\d{7,9}$$", multiLine: false);
    return regex.hasMatch(phone);
  }
  static  bool isEqualDateFilter(DateTime objDate, DateTime fromDate, DateTime toDate) {
    String fromDateString =  formatDate(fromDate);
    String toDateString =  formatDate(toDate);
    return objDate.compareTo(new intl.DateFormat("dd-MM-yyyy").parse(fromDateString)) >= 0 && objDate.compareTo(new intl.DateFormat("dd-MM-yyyy").parse(toDateString)) <= 0;

  }
  static String getCurrentDate(){
    DateTime now = new DateTime.now();
    var formatter = new intl.DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
  static String formatDate(DateTime dateTime){
    var formatter = new intl.DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }
  static String formatTime(DateTime dateTime){
    var formatter = new intl.DateFormat('hh:mm a');
    return formatter.format(dateTime);
  }
  static Future<bool> isEnableBT(BlueThermalPrinter blueThermalPrinter) async{
    return await blueThermalPrinter.isOn ?? false;

  }


  static confirmDialog(BuildContext context,String title,String content){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: 36,
                    bottom: 4,
                    left: 4,
                    right:4,
                  ),
                  margin: EdgeInsets.only(top: 30),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: const Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // To make the card compact
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        content,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          children: <Widget>[

                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context,false); // To close the dialog
                                },
                                child: Text("Cancel",style: TextStyle(color: Theme.of(context).primaryColor),),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context,true); // To close the dialog
                                },
                                child: Text("OK",style: TextStyle(color: Theme.of(context).primaryColor),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blue,
                    child: Text('?',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 40),),
                  ),
                ),
              ],
            ),
          );
        });
  }

}