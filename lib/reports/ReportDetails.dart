import 'dart:convert';
import 'dart:typed_data';

import 'package:blue_print_pos/blue_print_pos.dart';
import 'package:blue_print_pos/models/blue_device.dart';
import 'package:blue_print_pos/receipt/receipt_alignment.dart';
import 'package:blue_print_pos/receipt/receipt_section_text.dart';
import 'package:blue_print_pos/receipt/receipt_text_size_type.dart';
import 'package:blue_print_pos/receipt/receipt_text_style_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:esc_pos_utils_plus/src/enums.dart';

import '../bloc/sale_bloc/SaleBloc.dart';
import '../common/Utils.dart';
import '../model/BtDevice.dart';
import '../model/Order.dart';
import '../widgets/Toasts.dart';

class ReportDetails extends StatefulWidget {
  Sale item;
  int prefix;
  ReportDetails({this.prefix, this.item});

  @override
  State<ReportDetails> createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  final BluePrintPos _bluePrintPos = BluePrintPos.instance;
  List<Order> lstOrder = [];
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
      floatingActionButton: FloatingActionButton.extended(
        extendedPadding:
        EdgeInsets.symmetric(horizontal: 35.0, vertical: 30.0),
        icon: Icon(
          Icons.print,
          color: Colors.white,
          size: 30,
        ),
        label: Text(
          'Print',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Utils.showPrintDialog(context);
          printInvoice();
        },
      ),
      backgroundColor: Colors.grey.shade100,
      body: BlocBuilder<SaleBloc,SaleState>(
        builder: (context,state){
          if(state is Success){
            lstOrder.clear();
            lstOrder.addAll(state.result);
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
                            Text('Amount',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                            Text('${widget.item.amount}',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
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
                            Text('Total',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                            Text('${widget.item.total}',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
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
        Utils.dismissDialog(context);
        Toasts.greenToast("No connected printer found!");
      }
    } on PlatformException {}
  }
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
        "#${widget.prefix}-"+"${int.parse(widget.item.invoiceNo)+ 1000}",
        widget.item.date,
        leftSize: ReceiptTextSizeType.medium,
        leftStyle: ReceiptTextStyleType.bold,
        rightSize: ReceiptTextSizeType.small);
    receiptText.addSpacer(count: 2);

    for (int i = 0; i < lstOrder.length; i++) {
      receiptText.addLeftRightText(
          "${lstOrder[i].name.isEmpty ? lstOrder[i].nameMyanmar : lstOrder[i].name}",
          '${lstOrder[i].quantity} \tx\t\t' + lstOrder[i].amount,
          leftSize: ReceiptTextSizeType.small,
          rightSize: ReceiptTextSizeType.small);
      receiptText.addText(
          "${lstOrder[i].name.isEmpty ? '' : lstOrder[i].nameMyanmar}",
          size: ReceiptTextSizeType.small,
          alignment: ReceiptAlignment.left);
      receiptText.addSpacer(useDashed: true);
    }

    receiptText.addLeftRightText('Total', widget.item.amount.toString(),
        leftStyle: ReceiptTextStyleType.bold,
        leftSize: ReceiptTextSizeType.small,
        rightStyle: ReceiptTextStyleType.bold,
        rightSize: ReceiptTextSizeType.small);
    receiptText.addSpacer();
    receiptText.addLeftRightText('Discount', widget.item.discount.toString() + '\t%',
        leftStyle: ReceiptTextStyleType.normal,
        leftSize: ReceiptTextSizeType.small,
        rightStyle: ReceiptTextStyleType.normal,
        rightSize: ReceiptTextSizeType.small);
    receiptText.addSpacer(count: 1);
    receiptText.addLeftRightText('Net Amount', '${widget.item.total}',
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

    _bluePrintPos
        .printReceiptText(receiptText, paperSize: PaperSize.mm80)
        .then((value) => {
      Utils.dismissDialog(context),
    });

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
