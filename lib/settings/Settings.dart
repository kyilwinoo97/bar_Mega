import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingState();
}

class _SettingState extends State<Settings> {
  // final doc = pw.Document();

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Row(
        children :[
          Container(
            width: mQuery.width * 0.3,
            child: Column(
            children: [
             Card(
                  elevation: 5,
                  shadowColor: Colors.grey,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 24,horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Printer Settings",style: TextStyle(
                          color: Colors.grey,
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),),
                        Icon(Icons.arrow_forward_ios_outlined),
                      ],
                    ),
                  ),
                ),
              Card(
                  elevation: 5,
                  shadowColor: Colors.grey,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 24,horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Log Out",style: TextStyle(
                          color: Colors.grey,
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),),
                        Icon(Icons.arrow_forward_ios_outlined),
                      ],
                    ),
                  ),
                ),
            ],
        ),
          ),
          VerticalDivider(
            width: 0.5,
            color: Colors.black,
          ),
          Container(
            child: Column(
              children: [
                Text("Devices"),
              ],
            ),
          )
      ]
      ),
    );
  }
}
