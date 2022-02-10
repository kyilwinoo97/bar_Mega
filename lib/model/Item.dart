class Item{
  int itemId;
  String nameEng;
  String nameMyan;
  String printName;
  String price;
  String unit;
  String path;
  String category;

  Item({this.itemId,  this.nameEng,this.nameMyan,this.printName, this.price,  this.unit,  this.path,
       this.category});
  Item.fromMap(Map<String, dynamic> map)
      : itemId = map['itemId'],
        nameEng = map['nameEng'],
        nameMyan = map['nameMyan'],
        printName = map['printName'],
        price = map['price'],
        unit = map['unit'],
        path = map['path'],
        category = map['category'];

  Map<String,dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['itemId'] = itemId;
    map['nameEng'] = nameEng;
    map['nameMyan'] = nameMyan;
    map['printName'] = printName;
    map['price'] = price;
    map['unit'] = unit;
    map['path'] = path;
    map['category'] = category;
    return map;
  }
}