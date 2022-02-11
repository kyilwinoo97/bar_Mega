import 'package:bar_mega/widgets/custom_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../common/Utils.dart';
import '../model/PurchaseItemModel.dart';
import 'Purchase.dart';

class NewPurchase extends StatefulWidget {
  Function onSave;
  NewPurchase({this.onSave});

  @override
  State<NewPurchase> createState() => _NewPurchaseState();
}

class _NewPurchaseState extends State<NewPurchase> {
  String selectedUnit = "Select Unit";

  List<String> unitItems = [
    "bottle","bag","kg"
  ];

  DateTime _date = DateTime.now();
  PurchaseItemModel newItem;

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _qtyController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _supplierController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();

  final TextStyle nameTextStyle = TextStyle(
    fontSize: 18.0,
    color: Colors.green
  );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Container(
          height: size.height * 9/10,
          child: Column(
            children: [
              Text('New Purchase',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
              const SizedBox(height: 30.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text('Name',style: nameTextStyle,)),
                  Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: inputWidget(controller: _nameController),
                      ))
                ],
              ),
              const SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text('Quantity',style: nameTextStyle)),
                  Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: inputWidget(controller: _qtyController,type: TextInputType.number),
                      ))
                ],
              ),
              const SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text('Unit',style: nameTextStyle)),
                  Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: DropdownButtonFormField2(
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          isExpanded: true,
                          hint: Text(
                            selectedUnit,
                            style: TextStyle(fontSize: 14,color: Colors.black),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                          buttonHeight: 60,
                          buttonPadding: const EdgeInsets.only(
                              left: 20, right: 10),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          items: unitItems
                              .map((item) =>
                              DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select Unit.';
                            } else {
                              return "";
                            }
                          },
                          onChanged: (value) {
                            selectedUnit = value.toString();
                          },
                        ),
                      ))
                ],
              ),
              const SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text('Price',style: nameTextStyle)),
                  Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: inputWidget(controller: _priceController,type: TextInputType.number),
                      ))
                ],
              ),
              const SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text('Supplier',style: nameTextStyle)),
                  Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: inputWidget(controller: _supplierController),
                      ))
                ],
              ),
              const SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text('Discount',style: nameTextStyle)),
                  Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: inputWidget(controller: _discountController,type: TextInputType.number),
                      ))
                ],
              ),
              const SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text('Total',style: nameTextStyle)),
                  Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: inputWidget(controller: _totalController,type: TextInputType.number),
                      ))
                ],
              ),
              const SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text('Date',style: nameTextStyle)),
                  Expanded(
                      flex: 7,
                      child: GestureDetector(
                        onTap: (){
                          DatePicker.showDatePicker(
                            context,
                            currentTime: this._date,
                            theme: Utils.kDateTimePickerTheme,
                            showTitleActions: true,
                            onConfirm: (date) {
                              setState(() {
                                this._date = date;
                              });
                            },
                          );
                        },
                        child: Container(
                          height: 50.0,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, style: BorderStyle.solid,),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(child: Text("${this._date.day} / ${this._date.month} / ${this._date.year}",style: TextStyle(
                            fontSize: 18.0
                          ),)),
                        ),
                      ))
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150.0,
                      height: 70.0,
                      padding: EdgeInsets.all(5.0),child: CustomButton(label: 'Cancel',color: Colors.red,onTap: (){
                        Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Purchase()));
                  },)),
                  Container(
                    width: 150.0,
                      height: 70.0,
                      padding: EdgeInsets.all(5.0),child: CustomButton(label: 'Add',color: Colors.green,onTap: (){
                        newItem = PurchaseItemModel(
                          name: _nameController.text,
                          qty: _qtyController.text,
                          unit: selectedUnit,
                          price: _priceController.text,
                          supplier: _supplierController.text.isEmpty ? "":_supplierController.text,
                          date: Utils.formatDate(_date),
                          discount: _discountController.text.isEmpty ? "" : _discountController.text,
                          total: _totalController.text.isEmpty ? "": _totalController.text
                        );
                        widget.onSave(newItem);
                  },)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget inputWidget({TextEditingController controller, TextInputType type=TextInputType.text}) {
  return Container(
    width: double.infinity,
    height: 50,
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey, style: BorderStyle.solid,),
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: TextFormField(
        controller: controller,
        keyboardType: type,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
        )),
  );
}