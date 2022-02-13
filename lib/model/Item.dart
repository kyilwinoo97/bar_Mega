import 'package:flutter/cupertino.dart';

class Item{
  int itemId;
  String name;
  String nameMyanmar;
  String price;
  String unit;
  String path;
  String category;

  Item({this.itemId,  this.name,@required this.nameMyanmar, this.price,  this.unit,  this.path,
       this.category});
  Item.fromMap(Map<String, dynamic> map)
      : itemId = map['itemId'],
        name = map['name'],
        nameMyanmar = map['nameMyanmar'],
        price = map['price'],
        unit = map['unit'],
        path = map['path'],
        category = map['category'];

  Map<String,dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['itemId'] = itemId;
    map['name'] = name;
    map['nameMyanmar'] = nameMyanmar;
    map['price'] = price;
    map['unit'] = unit;
    map['path'] = path;
    map['category'] = category;
    return map;
  }
}