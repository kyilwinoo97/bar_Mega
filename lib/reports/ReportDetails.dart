import 'package:flutter/material.dart';

class ReportDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Report Details'),
        elevation: 0.0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Center(
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
                        Text('#1-1094'),
                        Text('12-2-2022')
                        // Text("#$prefix-"+"${int.parse(orderDetails[0].invoiceNo)+ 1000}",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                        // Text(orderDetails[0].date)
                      ],
                    ),
                    SizedBox(height: 20.0),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context,index){
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Item Name'),
                                  Text('2 \tx\t\t'+'5000'),
                                  // Text(orderDetails[index].name),
                                  // Text('${orderDetails[index].quantity} \tx\t\t'+orderDetails[index].amount),
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
                        Text('50000',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Discount',style: TextStyle(fontSize: 14.0),),
                        Text('5' + ' %',style: TextStyle(fontSize: 14.0),),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Amount',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                        Text('10',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Divider(color: Colors.grey.shade500,),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}
