import 'dart:convert';
import 'dart:typed_data';

import 'package:bar_mega/bloc/sale_bloc/SaleBloc.dart';
import 'package:bar_mega/bloc/table_bloc/TableBloc.dart';
import 'package:bar_mega/common/Utils.dart';
import 'package:bar_mega/model/BlueDevice.dart';
import 'package:bar_mega/model/Desk.dart';
import 'package:bar_mega/model/Order.dart';
import 'package:bar_mega/sale/SaleTables.dart';
import 'package:bar_mega/tables/TableList.dart';
import 'package:bar_mega/widgets/Toasts.dart';
import 'package:bar_mega/widgets/custom_button.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;

class OrderDetails extends StatefulWidget {
  final Desk desk;
  OrderDetails(this.desk);
  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List<Order> orderDetails;
  double total = 0.0;
  int prefix = 0 ;
  String invoiceNo = "";
  String date = "";
  int discount  = 0;
  ScreenshotController screenshotController = ScreenshotController();
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;


  @override
  void initState() {
    super.initState();
    orderDetails = OrderList.list ?? [];
    for(int i = 0; i< orderDetails.length; i ++){
      total += double.parse(orderDetails[i].total);
      invoiceNo = orderDetails[i].invoiceNo;
      date = orderDetails[i].date;
      discount = int.parse(orderDetails[i].discount);
    }
    prefix = ((int.parse(orderDetails[0].invoiceNo) + 1000) /1000).floor();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      leading: IconButton(
        onPressed: (){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          SaleTables()), (Route<dynamic> route) => false);
        },
        icon: Icon(Icons.arrow_back,color: Colors.white,),
      ),
      elevation: 0.0,
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            height: 50.0,
            width: 150.0,
            child: InkWell(
              onTap: (){
                BlocProvider.of<SaleBloc>(context).add(AddSale(Sale(
                  invoiceNo: invoiceNo,
                  name:"Sale",
                  quantity: orderDetails.length,
                  amount: total.toString(),
                  discount: discount.toString(),
                  date: date,
                  total: total.toString()
                )));


              },
              child: Card(
                  elevation: 0.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.attach_money,color: Colors.green,size: 30,),
                      const SizedBox(width: 5.0,),
                      Text(
                        'Charge',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
          ),
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 15.0),
          //   height: 50.0,
          //   width: 150.0,
          //   child: GestureDetector(
          //     onTap: (){},
          //     child: Card(
          //         elevation: 0.0,
          //         color: Colors.white,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(20.0),
          //         ),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Icon(Icons.print,color: Colors.green,size: 30,),
          //             const SizedBox(width: 5.0,),
          //             Text(
          //               'Print',
          //               style: TextStyle(
          //                   color: Colors.green,
          //                   fontSize: 18.0,
          //                   fontWeight: FontWeight.bold),
          //             ),
          //           ],
          //         )),
          //   ),
          // )
        ],
      ),
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child:BlocListener<SaleBloc, SaleState>(
          listener: (context, state) {
            if(state is SaleSuccess){
              BlocProvider.of<TableBloc>(context).add(UpdateTable(Desk(
                  deskId: widget.desk.deskId,
                  tableNo: widget.desk.tableNo,
                  invoiceNo: "",
                  noOfSeats: widget.desk.noOfSeats,
                  status: "Available")));

              //print voucher
              printInvoice();
            }
          },
          child: Screenshot(
            controller: screenshotController,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              width: size.width / 2.5,
              height: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5.0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset("assets/images/logo_bar_mega.png",fit: BoxFit.fill,height: 80,)
                      ),
                      const SizedBox(height: 10.0),
                      Align(
                        alignment: Alignment.center,
                          child: Text('Bar Mega',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),)),
                      const SizedBox(height: 14.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("#$prefix-"+"${int.parse(orderDetails[0].invoiceNo)+ 1000}",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                          Text(orderDetails[0].date)
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
        ),
      ),
    );
  }

  void printInvoice() {
    Utils.isEnableBT(bluetooth).then((value) => {
      if (value)
        {
          _connect(),
        }
      else
        {
          Toasts.greenToast("Please enable bluetooth!"),
        }
    });
  }

  _connect() async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      BlueDevice bt = BlueDevice.fromJson(json.decode(prefs.getString("Printer")));

        if(bt != null){
          BluetoothDevice device = BluetoothDevice(bt.name, bt.address);
          bluetooth.isConnected.then((isConnected) => {
            if (!isConnected)
              {
                bluetooth.connect(device).then((value) => {
                  printVoucher(),
                }),
              }
          });
        }else{
          Toasts.greenToast("No connected printer found!");
        }
    } on PlatformException {}
  }

  printVoucher() {
    screenshotController
        .capture(pixelRatio: 1.5, delay: Duration(milliseconds: 200))
        .then((Uint8List capturedImage) async {
      bluetooth.isConnected.then((isConnected) {
        if (isConnected) {

          List<Uint8List> imgList = [];

          img.Image receiptImg = img.decodePng(capturedImage);
          for (var i = 0; i <= receiptImg.height; i += 200) {
            img.Image cropedReceiptImg = img.copyCrop(receiptImg, 0, i, receiptImg.width, 200);

            var bytes = img.encodePng(cropedReceiptImg);

            imgList.add(bytes as Uint8List);
          }
          imgList.forEach((element) {
            bluetooth.printImageBytes(element.buffer.asUint8List(element.offsetInBytes, element.lengthInBytes));
          });
          bluetooth.printNewLine();
          bluetooth.printCustom("--------------------------------", 1, 1);
          bluetooth.paperCut();
        }
        Future.delayed(new Duration(seconds: 10),(){
          bluetooth.disconnect();

        });
      });

    }).catchError((onError) {
      print(onError);
    });
  }
}
