import 'package:bar_mega/menu/Menu.dart';
import 'package:bar_mega/reports/ReportChart.dart';
import 'package:bar_mega/sale/SaleList.dart';
import 'package:bar_mega/sale/SaleTables.dart';
import 'package:bar_mega/settings/Settings.dart';
import 'package:bar_mega/tables/TableList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../purchase/Purchase.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_HomeSate();

}

class _HomeSate extends State<Home>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HomeItem("Sale",Image.asset("assets/images/sales.png"),(){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => SaleTables()));
                  }),
                  HomeItem("Purchase",Image.asset("assets/images/shopping_cart.png"),(){
                    Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => Purchase()
                    ));
                  }),
                  HomeItem("Reports",Image.asset("assets/images/business_report.png"),(){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => ReportChart()));
                  }),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HomeItem("Menu",Image.asset("assets/images/menu.png"),(){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => ItemList()));
                  }),
                  HomeItem("Tables",Image.asset("assets/images/table.png"),(){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => TableList()));
                  }),
                  HomeItem("Settings",Image.asset("assets/images/settings.png"),(){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => PrinterSetting()));

                  }),
              ],)
            ],
          ),
        ),
    );
  }
}
class HomeItem extends StatelessWidget{
  final String text;
  final Image image;
  Function() onTap;
  HomeItem(this.text,this.image,this.onTap);
  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: mQuery.width * 0.2,
              height: mQuery.height * 0.2,
              child: image),
          SizedBox(
            height: 10,
          ),
          Text(text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),),
        ],
      ),
    );
  }

}

