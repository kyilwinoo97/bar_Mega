import 'package:bar_mega/bloc/sale_bloc/SaleBloc.dart';
import 'package:bar_mega/db/DbHelper.dart';
import 'package:bar_mega/reports/ReportDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/Order.dart';

class ReportList extends StatefulWidget {
  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {

  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Report'),
        elevation: 0.0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: BlocBuilder<SaleBloc,SaleState>(
        builder: (context,state){
          if(state is AllSaleSuccess){
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: GridView.count(crossAxisCount: 4,
                childAspectRatio: (itemWidth / itemHeight),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: List.generate(state.result.length, (index) {
                  int prefix = ((int.parse(state.result[index].invoiceNo) + 1000) /1000).floor();
                  return Container(
                    margin: EdgeInsets.all(5.0),
                    height: 100.0,
                    child: ReportItem(prefix: prefix,item: state.result[index]),
                  );
                }),),
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
        },
      ),
    );
  }
  void getData(){
    BlocProvider.of<SaleBloc>(context).add(GetAllSale());
  }
}

class ReportItem extends StatelessWidget {
  Sale item;
  int prefix;
  ReportItem({this.prefix, this.item});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
      Navigator.push(
          context, MaterialPageRoute(
        builder: (context) => ReportDetails(prefix: prefix,item: item,),
      )
      );
    },
      child: Card(
        elevation: 5.0,
        shadowColor: Colors.white54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("#$prefix-"+"${int.parse(item.invoiceNo)+ 1000}",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
              const SizedBox(height: 5.0,),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "${item.total}", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0)),
                    TextSpan(
                      text: '\tKs',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5.0,),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Discount', style: TextStyle(fontSize: 14.0)),
                    TextSpan(
                      text: '\t${item.discount} %',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.date_range,size:
                  20.0,color: Colors.blueGrey,),
                  const SizedBox(width: 10.0,),
                  Text('${item.date}'),
                ],
              ),
            ],
          ),
        ),),
    );
  }
}

