import 'package:bar_mega/bloc/table_bloc/TableBloc.dart';
import 'package:bar_mega/model/Desk.dart';
import 'package:bar_mega/tables/TableDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TableList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _TableListState();

}

class _TableListState extends State<TableList> {
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
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("Table"),
     ),
     floatingActionButton: Container(
       height: 60.0,
       width: 60.0,
       child: FittedBox(
         child: FloatingActionButton(
           backgroundColor: CupertinoColors.activeGreen,
           onPressed: () {
             Navigator.push(context,
                 MaterialPageRoute(builder: (context) => TableDetail(title: "Create Table")));

           },
           tooltip: "Add Table",
           child: Icon(
             Icons.add,
             size: 25,
           ),
         ),
       ),
     ),
     body: BlocBuilder<TableBloc,TableState>(
       builder: (context,state) {
         if(state is Success){
          return Container(
             child: GridView.count(
               crossAxisCount: 5,
               scrollDirection: Axis.vertical,
               children: List.generate(state.result.length, (index) {
                 return InkWell(child: TableItem(state.result[index]),onTap: (){
                   Navigator.push(context,
                       MaterialPageRoute(builder: (context) => TableDetail(title: "Update Table",desk: state.result[index],)));
                 },);
               }),
             ),
           );
         }else if(state is Failure){
           return Center(
             child: Text(state.message),
           );
         }else{
           return Center(
             child: CircularProgressIndicator(color: Colors.green,),
           );
         }

       }
     ),
   );
  }

  void getData() {
    BlocProvider.of<TableBloc>(context).add(GetAllTable());
  }
}

class TableItem extends StatelessWidget {
  final Desk table;
  TableItem(this.table);
  @override
  Widget build(BuildContext context) {
    return Container(
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
          Divider(height: 0.4,color: Colors.grey,),

        ],
      ),
    );
  }
}