import 'package:bar_mega/model/Order.dart';
import 'package:bar_mega/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List<Order> orderDetails;
  double total = 0.0;

  @override
  void initState() {
    super.initState();
    orderDetails = OrderList.list ?? [];
    for(int i = 0; i< orderDetails.length; i ++){
      total += double.parse(orderDetails[i].total);
    }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      elevation: 0.0,
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            height: 50.0,
            width: 150.0,
            child: GestureDetector(
              onTap: (){},
              child: Card(
                  elevation: 0.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.print,color: Colors.green,size: 30,),
                      const SizedBox(width: 5.0,),
                      Text(
                        'Print',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          width: size.width / 2.5,
          height: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 5.0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                      child: Text('Bar Mega',style: TextStyle(fontSize: 20.0),)),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Table No 1',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                      Text('11-2-2022')
                    ],
                  ),
                  SizedBox(height: 20.0),
                  ListView.builder(
                    shrinkWrap: true,
                      itemCount: orderDetails.length,
                      itemBuilder: (context,index){
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(orderDetails[index].name),
                                  Text(orderDetails[index].amount),
                                ],
                              ),
                              const SizedBox(height: 5.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${orderDetails[index].quantity}'),
                                ],
                              ),
                              Divider(color: Colors.grey.shade500,),
                            ],
                          );
                  }),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                      Text(total.toString(),style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
