class Item{
  int itemId;
  String name;
  String price;
  String unit;
  String path;
  int qty = 1;
  String category;

  Item({this.itemId,  this.name,  this.price,  this.unit,  this.path,this.qty = 1,
       this.category});
  Item.fromMap(Map<String, dynamic> map)
      : itemId = map['itemId'],
        name = map['name'],
        price = map['price'],
        unit = map['unit'],
        path = map['path'],
        qty = map['qty'],
        category = map['category'];

  Map<String,dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['itemId'] = itemId;
    map['name'] = name;
    map['price'] = price;
    map['unit'] = unit;
    map['path'] = path;
    map['qty'] = qty;
    map['category'] = category;
    return map;
  }
}