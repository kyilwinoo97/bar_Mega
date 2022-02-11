import 'package:flutter/material.dart';

import '../model/Desk.dart';

class TableItem extends StatelessWidget {
  final Desk table;
  TableItem(this.table);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        shadowColor: Colors.white54,
        color: Colors.white,
        child: Column(
          children: [
            Flexible(
              child: Container(
                child:Image.asset("assets/images/table.png",fit: BoxFit.fill,height: 100,),
              ),
            ),
            Container(
              padding: EdgeInsets.all(4),
              child: Text("Table No. : " + table.tableNo,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
            ),
            Container(
              padding: EdgeInsets.all(4),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children :[ Text("No. Of Seats : ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),),
                    Text(table.noOfSeats.toString(),
                      style: TextStyle(
                          color:  Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),),
                  ]
              ),
            ),
            Container(
              padding: EdgeInsets.all(4),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children :[ Text("Status : ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),),
                    Text(table.status,
                      style: TextStyle(
                          color: table.status =="Available" ? Colors.green : Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),),
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}