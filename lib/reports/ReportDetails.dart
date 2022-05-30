import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sale_bloc/SaleBloc.dart';
import '../model/Order.dart';

class ReportDetails extends StatefulWidget {
  Sale item;
  int prefix;
  ReportDetails({this.prefix, this.item});

  @override
  State<ReportDetails> createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Report Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            BlocProvider.of<SaleBloc>(context).add(GetAllSale());
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.grey.shade100,
      body: BlocBuilder<SaleBloc,SaleState>(

        builder: (context,state){
          if(state is Success){
            return Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                width: size.width / 2.5,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 2.0,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("#${widget.prefix}-"+"${int.parse(widget.item.invoiceNo)+ 1000}",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                            Text('${widget.item.date}')
                          ],
                        ),
                        SizedBox(height: 20.0),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.result.length,
                            itemBuilder: (context,index){
                              bool isNameEnglish = state.result[index].name.isNotEmpty;
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      isNameEnglish?Text('${state.result[index].name}\n${state.result[index].nameMyanmar}'):Text('${state.result[index].nameMyanmar}'),
                                      Text('${state.result[index].quantity} \tx\t\t'+'${state.result[index].amount}'),
                                    ],
                                  ),
                                  const SizedBox(height: 5.0,),
                                  Divider(color: Colors.grey.shade500,),
                                ],
                              );
                            }),
                        const SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                            Text('${widget.item.total}',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Discount',style: TextStyle(fontSize: 14.0),),
                            Text('${widget.item.discount}' + ' %',style: TextStyle(fontSize: 14.0),),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Amount',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                            Text('${widget.item.amount}',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Divider(color: Colors.grey.shade500,),
                      ],
                    ),
                  ),
                ),
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
        },
      ),
    );
  }
  void getData(){
    BlocProvider.of<SaleBloc>(context).add(GetOrderByInvoice(widget.item.invoiceNo));
  }
}
