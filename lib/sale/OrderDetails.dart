import 'dart:convert';
import 'dart:typed_data';

import 'package:bar_mega/bloc/sale_bloc/SaleBloc.dart';
import 'package:bar_mega/bloc/table_bloc/TableBloc.dart';
import 'package:bar_mega/common/Utils.dart';
import 'package:bar_mega/model/BtDevice.dart';
import 'package:bar_mega/model/Desk.dart';
import 'package:bar_mega/model/Order.dart';
import 'package:bar_mega/sale/SaleTables.dart';
import 'package:bar_mega/tables/TableList.dart';
import 'package:bar_mega/widgets/Toasts.dart';
import 'package:bar_mega/widgets/custom_button.dart';
import 'package:blue_print_pos/blue_print_pos.dart';
import 'package:blue_print_pos/models/models.dart';
import 'package:blue_print_pos/receipt/receipt.dart';
import 'package:esc_pos_utils_plus/src/enums.dart';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;

class OrderDetails extends StatefulWidget {
  final Desk desk;
  final int discount;
  OrderDetails(this.desk, this.discount);
  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List<Order> orderDetails;
  double total = 0.0;
  int prefix = 0;
  String invoiceNo = "";
  ScreenshotController screenshotController = ScreenshotController();
  // BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  final BluePrintPos _bluePrintPos = BluePrintPos.instance;
  double netAmount = 0.0;
  @override
  void initState() {
    super.initState();
    orderDetails = OrderList.list ?? [];
    for (int i = 0; i < orderDetails.length; i++) {
      total += double.parse(orderDetails[i].total);
      invoiceNo = orderDetails[i].invoiceNo;
    }
    if (widget.discount != 0) {
      netAmount = total - (total * (widget.discount.toDouble() / 100));
    } else {
      netAmount = total;
    }
    prefix = ((int.parse(orderDetails[0].invoiceNo) + 1000) / 1000).floor();
  }

  Future<bool> _willPopCallback() async {
    return false; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double widthPadding = size.width / 3;
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order Details'),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SaleTables()),
                  (Route<dynamic> route) => false);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          elevation: 0.0,
          actions: [
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 15.0),
            //   height: 50.0,
            //   width: 150.0,
            //   child: InkWell(
            //     onTap: () {
            //       BlocProvider.of<SaleBloc>(context).add(AddSale(Sale(
            //           invoiceNo: invoiceNo,
            //           name: "Sale",
            //           quantity: orderDetails.length,
            //           amount: total.toString(),
            //           discount: widget.discount.toString(),
            //           date: Utils.formatDate(DateTime.now()),
            //           total: total.toString())));
            //     },
            //     child: Card(
            //         elevation: 0.0,
            //         color: Colors.white,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20.0),
            //         ),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             const SizedBox(
            //               width: 5.0,
            //             ),
            //             Text(
            //               'Charge',
            //               style: TextStyle(
            //                   color: Colors.green,
            //                   fontSize: 18.0,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //           ],
            //         )),
            //   ),
            // ),
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
        floatingActionButton: Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: FloatingActionButton.extended(
            extendedPadding:
                EdgeInsets.symmetric(horizontal: 35.0, vertical: 30.0),
            icon: Icon(
              Icons.attach_money,
              color: Colors.white,
              size: 30,
            ),
            label: Text(
              'Charge',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              BlocProvider.of<SaleBloc>(context).add(AddSale(Sale(
                  invoiceNo: invoiceNo,
                  name: "Sale",
                  quantity: orderDetails.length,
                  amount: total.toString(),
                  discount: widget.discount.toString(),
                  date: Utils.formatDate(DateTime.now()),
                  total: total.toString())));
            },
          ),
        ),
        body: BlocListener<SaleBloc, SaleState>(
          listener: (context, state) {
            if (state is SaleSuccess) {
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
          child: SingleChildScrollView(
            child: Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 2.0,
                color: Colors.white,
                child: SizedBox(
                  width: size.width / 2,
                  height: size.height * 2,
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: Image.asset(
                        "assets/images/logo_bar_mega.png",
                        fit: BoxFit.fill,
                        height: 80,
                      )),
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "#$prefix-" +
                                "${int.parse(orderDetails[0].invoiceNo) + 1000}",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            orderDetails[0].date,
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: orderDetails.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      (orderDetails[index].name.isNotEmpty
                                          ? orderDetails[index].name
                                          : orderDetails[index].nameMyanmar) +
                                              '\n' +
                                          (orderDetails[index].name.isEmpty?'':orderDetails[index].nameMyanmar),
                                      overflow: TextOverflow.visible,
                                      softWrap: true,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                        '${orderDetails[index].quantity} \tx\t\t' +
                                            orderDetails[index].amount),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey.shade500,
                                ),
                              ],
                            );
                          }),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            total.toString(),
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discount',
                            style: TextStyle(fontSize: 14.0),
                          ),
                          Text(
                            widget.discount.toString() + ' %',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Amount',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${netAmount.toPrecision(1)}",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey.shade500,
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.center,
                        child: Text('အားပေးမှုအတွက် ကျေးဇူးတင်ရှိပါသည်။'),
                      ),
                      const SizedBox(height: 100.0),
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
    _connect();
    // Utils.isEnableBT(_bluePrintPos).then((value) => {
    //   if (value)
    //     {
    //       _connect(),
    //     }
    //   else
    //     {
    //       Toasts.greenToast("Please enable bluetooth!"),
    //     }
    // });
  }

  _connect() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String printerJson = prefs.get("Printer") ?? "";
      BtDevice bt = printerJson.isNotEmpty
          ? BtDevice.fromJson(json.decode(printerJson))
          : null;

      print(
          "###########################################> ${_bluePrintPos.isConnected}");
      if (_bluePrintPos.isConnected) {
        _onPrintReceipt();
      } else if (bt != null) {
        BlueDevice device = BlueDevice(name: bt.name, address: bt.address);

        if (!_bluePrintPos.isConnected) {
          _bluePrintPos.connect(device).then((value) => {
                print("----------------->${value}"),
                _onPrintReceipt(),
              });
        }
        // _bluePrintPos.isConnected.then((isConnected) => {
        //   if (!isConnected)
        //     {
        //
        //     }
        // });
      } else {
        Toasts.greenToast("No connected printer found!");
      }
    } on PlatformException {}
  }

  // printVoucher() {
  //   screenshotController
  //       .capture(pixelRatio: 1.5, delay: Duration(milliseconds: 200))
  //       .then((Uint8List capturedImage) async {
  //     bluetooth.isConnected.then((isConnected) {
  //       if (isConnected) {
  //
  //         List<Uint8List> imgList = [];
  //
  //         img.Image receiptImg = img.decodePng(capturedImage);
  //         for (var i = 0; i <= receiptImg.height; i += 200) {
  //           img.Image cropedReceiptImg = img.copyCrop(receiptImg, 0, i, receiptImg.width, 200);
  //
  //           var bytes = img.encodePng(cropedReceiptImg);
  //
  //           imgList.add(bytes as Uint8List);
  //         }
  //         imgList.forEach((element) {
  //           bluetooth.printImageBytes(element.buffer.asUint8List(element.offsetInBytes, element.lengthInBytes));
  //         });
  //         bluetooth.printNewLine();
  //         bluetooth.printCustom("--------------------------------", 1, 1);
  //         bluetooth.paperCut();
  //       }
  //       Future.delayed(new Duration(seconds: 10),(){
  //         bluetooth.disconnect();
  //
  //       });
  //     });
  //
  //   }).catchError((onError) {
  //     print(onError);
  //   });
  // }

  Future<void> _onPrintReceipt() async {
    /// Example for Print Image
    final ByteData logoBytes = await rootBundle.load(
      'assets/images/logo_bar_mega_black.png',
    );

    /// Example for Print Text
    final ReceiptSectionText receiptText = ReceiptSectionText();
    receiptText.addImage(
      base64.encode(Uint8List.view(logoBytes.buffer)),
      width: 350,
    );
    receiptText.addSpacer();
    receiptText.addLeftRightText(
        "#$prefix-" + "${int.parse(orderDetails[0].invoiceNo) + 1000}",
        orderDetails[0].date,
        leftSize: ReceiptTextSizeType.medium,
        leftStyle: ReceiptTextStyleType.bold,
        rightSize: ReceiptTextSizeType.small);
    receiptText.addSpacer(count: 2);

    for (int i = 0; i < orderDetails.length; i++) {
      receiptText.addLeftRightText("${orderDetails[i].name.isEmpty?orderDetails[i].nameMyanmar:orderDetails[i].name}",
          '${orderDetails[i].quantity} \tx\t\t' + orderDetails[i].amount,
          leftSize: ReceiptTextSizeType.small,
          rightSize: ReceiptTextSizeType.small);
      receiptText.addText("${orderDetails[i].name.isEmpty?'':orderDetails[i].nameMyanmar}",
          size: ReceiptTextSizeType.small, alignment: ReceiptAlignment.left);
      receiptText.addSpacer(useDashed: true);
    }

    receiptText.addLeftRightText('Total', total.toString(),
        leftStyle: ReceiptTextStyleType.bold,
        leftSize: ReceiptTextSizeType.small,
        rightStyle: ReceiptTextStyleType.bold,
        rightSize: ReceiptTextSizeType.small);
    receiptText.addSpacer();
    receiptText.addLeftRightText('Discount', widget.discount.toString() + '\t%',
        leftStyle: ReceiptTextStyleType.normal,
        leftSize: ReceiptTextSizeType.small,
        rightStyle: ReceiptTextStyleType.normal,
        rightSize: ReceiptTextSizeType.small);
    receiptText.addSpacer(count: 1);
    receiptText.addLeftRightText('Net Amount', '${netAmount.toPrecision(1)}',
        leftStyle: ReceiptTextStyleType.bold,
        leftSize: ReceiptTextSizeType.small,
        rightStyle: ReceiptTextStyleType.bold,
        rightSize: ReceiptTextSizeType.small);
    receiptText.addSpacer(useDashed: true);
    receiptText.addText(
      'အားပေးမှုအတွက် ကျေးဇူးတင်ရှိပါသည်။',
      size: ReceiptTextSizeType.small,
      style: ReceiptTextStyleType.bold,
    );
    receiptText.addSpacer(count: 4);

    await _bluePrintPos.printReceiptText(receiptText,
        paperSize: PaperSize.mm80);

    /// Example for print QR
    // await _bluePrintPos.printQR('www.google.com', size: 250);
    //
    // /// Text after QR
    // final ReceiptSectionText receiptSecondText = ReceiptSectionText();
    // receiptSecondText.addText('Powered by ayeee',
    //     size: ReceiptTextSizeType.small);
    // receiptSecondText.addSpacer();
    // await _bluePrintPos.printReceiptText(receiptSecondText,
    //     feedCount: 1, paperSize: PaperSize.mm80);
  }
}
