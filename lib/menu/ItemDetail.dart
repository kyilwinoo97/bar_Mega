import 'package:bar_mega/model/Item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemDetail extends StatefulWidget {
  final Item item;
  ItemDetail({this.item});
  @override
  State<StatefulWidget> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  var url = "";


  final List<String> unitItems = [];
  final List<String> categoryItems = [];

  String selectedUnit;
  String selectedCategory;
  String title = "Create Menu";
  String buttonText = "Save";
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if(widget.item != null){
      nameController.text = widget.item.name;
      priceController.text = widget.item.price.toString();
      title = "Update Menu";
      buttonText = "Update";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context).size;
    var width = mQuery.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),

      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Card(
                    shadowColor: Colors.grey,
                    elevation: 5.0,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Name"),
                              SizedBox(
                                width: 10,
                              ),
                              inputWidget(
                                  width: width * 0.3,
                                  controller: nameController),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Price"),
                              SizedBox(
                                width: 10,
                              ),
                              inputWidget(
                                  width: width * 0.3,
                                  controller: priceController),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Unit"),
                              SizedBox(width:32),
                              Container(
                                width: width * 0.28,
                                child: DropdownButtonFormField2(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  isExpanded: true,
                                  hint: const Text(
                                    'Select Unit',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black45,
                                  ),
                                  iconSize: 30,
                                  buttonHeight: 60,
                                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
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
                                    }else{
                                      return "";
                                    }
                                  },
                                  onChanged: (value) {
                                    selectedUnit = value.toString();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Category"),
                              SizedBox(width: 10),
                              Container(
                                width: width * 0.28,
                                child: DropdownButtonFormField2(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  isExpanded: true,
                                  hint: const Text(
                                    'Select Category',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black45,
                                  ),
                                  iconSize: 30,
                                  buttonHeight: 60,
                                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  items: categoryItems
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
                                      return 'Please select Category.';
                                    }else{
                                      return "";
                                    }
                                  },
                                  onChanged: (value) {
                                    selectedCategory = value.toString();
                                  },

                                ),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          width: width * 0.35,
                          child: buttonWidget(
                              text: "Add Image",
                              color: Colors.black,
                              fontSize: 16,
                              spacing: 1,
                              fontWeight: FontWeight.bold,
                              onTap: () {}),
                        ),
                        Container(
                          child: url.isEmpty ? Image.asset("assets/images/logo.png",height: 100,width: 100,) : Image.network(url,height: 100,width: 100,),
                        ),
                        Container(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: width * 0.17,
                                child: buttonWidget(
                                    text: buttonText,
                                    color: Colors.black,
                                    fontSize: 20,
                                    spacing: 1,
                                    fontWeight: FontWeight.bold,
                                    onTap: () {}),
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              Container(
                                width: width * 0.17,
                                child: buttonWidget(
                                    text: "Cancel",
                                    color: Colors.black,
                                    fontSize: 20,
                                    spacing: 1,
                                    fontWeight: FontWeight.bold,
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    }),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget inputWidget({double width, TextEditingController controller}) {
  return Container(
    width: width,
    height: 50,
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey, style: BorderStyle.solid),
    ),
    child: TextFormField(
        controller: controller,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
        )),
  );
}

Widget buttonWidget(
    {String text,
    Color color,
    double fontSize,
    double spacing,
    FontWeight fontWeight,
    Function() onTap}) {
  return CupertinoButton(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      color: CupertinoColors.activeGreen,
      child: Text(text,
          style: TextStyle(
              color: color,
              fontWeight: fontWeight,
              fontSize: fontSize,
              letterSpacing: spacing)),
      onPressed: onTap);
}
