import 'package:bar_mega/menu/MenuDetail.dart';
import 'package:bar_mega/model/Unit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Dialogs{
  Dialogs._();

  static createUnit(BuildContext context) async {
    var mQuery = MediaQuery.of(context).size;
    TextEditingController controller = TextEditingController();
  return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
          const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          title: const Text(
            'Create Unit',
            style: TextStyle(fontSize: 21),
          ),
          content: SingleChildScrollView(
            child: Container(
              width: mQuery.width * 0.3,
              height: mQuery.height * 0.3,
              padding: EdgeInsets.only(bottom: 10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    top: BorderSide(
                      style: BorderStyle.solid,
                      color: Color(0xffAFB1B5)
                    ),
                      bottom: BorderSide(
                          style: BorderStyle.solid,
                          color: Color(0xffAFB1B5)),
                      left: BorderSide(
                          style: BorderStyle.solid,
                          color: Color(0xffAFB1B5)),
                      right: BorderSide(
                          style: BorderStyle.solid,
                          color: Color(0xffAFB1B5)))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text("Unit Name :",style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16
                    ),),
                  ),
                Container(
                width: mQuery.width * 0.25,
                height: 50,
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, style: BorderStyle.solid),
                ),
                child: TextFormField(
                    controller: controller,
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                    )),
              ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CupertinoButton(
                  color: CupertinoColors.activeGreen,
                  child: const Text('Yes',
                      style: TextStyle(fontSize: 21, color: Colors.black)),
                  onPressed: () {
                    if(controller.text.trim().isNotEmpty){
                      Navigator.of(context).pop(controller.text);
                    }else{
                      Fluttertoast.showToast(
                        msg: "Unit is Empty",
                        toastLength: Toast.LENGTH_SHORT,
                        fontSize: 13,
                        backgroundColor: Colors.green,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                      );
                    }
                  },
                ),
                CupertinoButton(
                  color: CupertinoColors.inactiveGray,
                  child: const Text('Cancel',
                      style: TextStyle(fontSize: 21, color: Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

}