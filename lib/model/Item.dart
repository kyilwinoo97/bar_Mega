class Item{
  int itemId;
  int unitId;
  String name;
  String price;
  String unit;
  String qty = "";
  String path;
  String category;

  Item({this.itemId,  this.unitId,  this.name,  this.price,  this.unit,  this.path,
       this.category});
  Item.fromMap(Map<String, dynamic> map)
      : itemId = map['itemId'],
        unitId = map['unitId'],
        name = map['name'],
        price = map['price'],
        unit = map['unit'],
        path = map['path'],
        qty = map['qty'],
        category = map['category'];

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['itemId'] = itemId;
    map['unitId'] = unitId;
    map['name'] = name;
    map['price'] = price;
    map['unit'] = unit;
    map['path'] = path;
    map['qty'] = qty;
    map['category'] = category;
    return map;
  }
}