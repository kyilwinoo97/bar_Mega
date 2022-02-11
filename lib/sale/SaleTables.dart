import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/table_bloc/TableBloc.dart';
import '../model/Desk.dart';
import '../tables/TableItem.dart';
import 'Sale.dart';

class SaleTables extends StatefulWidget {
  @override
  State<SaleTables> createState() => _SaleTablesState();
}

class _SaleTablesState extends State<SaleTables> {
  List<Desk> tableList = [
    Desk(deskId: 1,tableNo: "1",noOfSeats: 6,status: "Available"),
    Desk(deskId: 2,tableNo: "2",noOfSeats: 4,status: "Available"),
    Desk(deskId: 3,tableNo: "3",noOfSeats: 5,status: "Available"),
    Desk(deskId: 4,tableNo: "4",noOfSeats: 8,status: "Available"),
    Desk(deskId: 5,tableNo: "5",noOfSeats: 11,status: "Not Available"),
    Desk(deskId: 6,tableNo: "6",noOfSeats: 8,status: "Available"),
    Desk(deskId: 7,tableNo: "7",noOfSeats: 2,status: "Not Available"),
    Desk(deskId: 8,tableNo: "8",noOfSeats: 3,status: "Available"),
    //testing
    Desk(deskId: 9,tableNo: "9",noOfSeats: 4,status: "Available"),
    Desk(deskId: 10,tableNo: "10",noOfSeats: 4,status: "Not Available"),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Table'),elevation: 0.0,),
      backgroundColor: Colors.grey.shade100,
      body: BlocBuilder<TableBloc,TableState>(
          builder: (context,state) {
            // if(state is Success){
              return Container(
                child: GridView.count(
                  crossAxisCount: 5,
                  scrollDirection: Axis.vertical,
                  children: List.generate(tableList.length, (index) {
                    return InkWell(child: TableItem(tableList[index]),onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => Sale())
                      );
                    },);
                  }),
                ),
              );
            // }else if(state is Failure){
            //   return Center(
            //     child: Text(state.message),
            //   );
            // }else{
            //   return Center(
            //     child: CircularProgressIndicator(color: Colors.green,),
            //   );
            // }

          }
      ),
    );
  }
}
