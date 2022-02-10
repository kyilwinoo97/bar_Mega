import 'dart:io';

import 'package:bar_mega/bloc/menu_bloc/MenuBloc.dart';
import 'package:bar_mega/model/Item.dart';
import 'package:bar_mega/model/Unit.dart';
import 'package:bar_mega/repository/MainRepository.dart';
import 'package:bar_mega/widgets/Dialogs.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';


import '../Utils.dart';
import '../injection_container.dart';

class MenuDetail extends StatefulWidget {
  final Item item;
  final String category;

  MenuDetail({this.item,this.category});

  @override
  State<StatefulWidget> createState() => _MenuDetailState();
}

class _MenuDetailState extends State<MenuDetail> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  var url = "";


  final List<String> unitItems = [];
  final List<String> categoryItems = [];
  final List<Unit> unitList = [];

  String selectedUnit = "Select Unit";
  String selectedCategory = "Select Category";
  String title = "Create Menu";
  String buttonText = "Save";
  final _formKey = GlobalKey<FormState>();
  MainRepository repository;
  int unitId = -1;
  String imagePath = "";

  @override
  void initState() {
    repository = sl<MainRepository>();
    for(int i = 1 ; i< Utils.categoryList.length ; i ++){
      categoryItems.add(Utils.categoryList[i]);
    }
    if (widget.item != null) {
      nameController.text = widget.item.name;
      priceController.text = widget.item.price.toString();
      title = "Update Menu";
      buttonText = "Update";
      selectedUnit = widget.item.unit;
      unitId = widget.item.unitId;
      selectedCategory = widget.item.category;
      imagePath = widget.item.path;
    }
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery
        .of(context)
        .size;
    var width = mQuery.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          buttonText =="Update" ? IconButton(onPressed: (){
            deleteMenu(widget.item);
          }, icon: Icon(Icons.delete,color: Colors.white,size: 32,)):SizedBox.shrink(),
          SizedBox(width: 20,),
        ],
      ),
      body: BlocListener<MenuBloc,MenuState>(
        listener: (context,state){
          if (state is DeleteSuccess) {
            if(widget.category == Utils.All){
              BlocProvider.of<MenuBloc>(context).add(GetAllMenu());
            }else{
              BlocProvider.of<MenuBloc>(context).add(GetMenuByCategory(widget.category));
            }
            Navigator.of(context).pop();
          }
        },
        child: SingleChildScrollView(
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
                                SizedBox(width: 32),
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
                                      } else {
                                        return "";
                                      }
                                    },
                                    onChanged: (value) {
                                      selectedUnit = value.toString();
                                      for(int i = 0 ; i< unitList.length; i ++){
                                        if(unitList[i].name == selectedUnit){
                                          unitId = unitList[i].unitId;
                                        }
                                      }
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
                                    hint: Text(
                                      selectedCategory,
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
                                      } else {
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
                                onTap: () async {
                                  final ImagePicker _picker = ImagePicker();
                                  // Pick an image
                                  final XFile image = await _picker.pickImage(source: ImageSource.gallery);
                                  // FirebaseStorage storage =
                                  //     FirebaseStorage.instance;
                                  // if(image.path.isNotEmpty){
                                  //   File file = File(image.path);
                                  //   TaskSnapshot snapshot = await storage
                                  //       .ref()
                                  //       .child("images")
                                  //       .putFile(file);
                                  //   if(snapshot.state == TaskState.success){
                                  //     final String downloadUrl = await snapshot.ref.getDownloadURL();
                                  //     setState(() {
                                  //       url = downloadUrl;
                                  //     });
                                  //   }
                                  // }
                                }),
                          ),
                          Container(
                            child: url.isEmpty
                                ? Image.asset(
                              "assets/images/logo.png", height: 100, width: 100,)
                                : Image.network(url, height: 100, width: 100,),
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
                                      onTap: () {
                                        if (nameController.text
                                            .trim()
                                            .isNotEmpty && priceController.text
                                            .trim()
                                            .isNotEmpty &&
                                            selectedCategory != null) {
                                          if(buttonText =="Save"){
                                            saveMenu();
                                          }else{
                                            updateMenu();
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: "Please fill all field!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            fontSize: 13,
                                            backgroundColor: Colors.green,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                          );
                                        }
                                      }),
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
      ),
    );
  }



  void getData() async {
    List<Map> result = await repository.getAllUnit();
    List<String> lst = [];
    for (int i = 0; i < result.length; i ++) {
      unitList.add(Unit.fromMap(result[i]));
      lst.add(result[i]["name"]);
    }
    setState(() {
      unitItems.addAll(lst);
    });
  }

  void saveMenu() async{
    if(unitId != -1){
      var result = await repository.saveMenu(Item(unitId:unitId, name: nameController.text.toString(),
          price: priceController.text.toString(),unit: selectedUnit,path: "",category: selectedCategory));
      if(result > 0){
        if(widget.category == Utils.All){
          BlocProvider.of<MenuBloc>(context).add(GetAllMenu());
        }else{
          BlocProvider.of<MenuBloc>(context).add(GetMenuByCategory(widget.category));
        }
        Navigator.of(context).pop();
      }
    }else{
      //something went wrong
    }

  }

  void updateMenu() async{
    if(unitId > 0){
    var result = await  repository.updateMenu(Item(
          itemId: widget.item.itemId,
          unitId: unitId,
          name: nameController.text,
          price: priceController.text,
          unit: selectedUnit,
          path: imagePath,
          category: selectedCategory));
    if(result > 0){
      if(widget.category == Utils.All){
        BlocProvider.of<MenuBloc>(context).add(GetAllMenu());
      }else{
        BlocProvider.of<MenuBloc>(context).add(GetMenuByCategory(widget.category));
      }
      Navigator.of(context).pop();
    }
    }
  }

  void deleteMenu(Item item) {
    BlocProvider.of<MenuBloc>(context).add(DeleteMenu(item));
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

Widget buttonWidget({String text,
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