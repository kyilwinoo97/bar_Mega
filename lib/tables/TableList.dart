import 'package:bar_mega/bloc/table_bloc/TableBloc.dart';
import 'package:bar_mega/model/Desk.dart';
import 'package:bar_mega/tables/TableDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'TableItem.dart';

class TableList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _TableListState();

}

class _TableListState extends State<TableList> {

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