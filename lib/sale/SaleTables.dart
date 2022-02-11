import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/table_bloc/TableBloc.dart';
import '../model/Desk.dart';
import '../tables/TableItem.dart';
import 'SaleList.dart';

class SaleTables extends StatefulWidget {
  @override
  State<SaleTables> createState() => _SaleTablesState();
}

class _SaleTablesState extends State<SaleTables> {

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Table'),elevation: 0.0,),
      backgroundColor: Colors.grey.shade100,
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
                          MaterialPageRoute(
                              builder: (context) => SaleList(desk: state.result[index],))
                      );
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
