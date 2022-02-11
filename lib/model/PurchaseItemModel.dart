import 'dart:ffi';

class PurchaseItemModel{
  int purchaseId;
  String name;
  String qty;
  String unit;
  String date;
  String price; //amount
  String supplier;
  String discount;
  String total;

  PurchaseItemModel({this.purchaseId,this.name, this.qty, this.unit, this.date, this.price,
      this.supplier, this.discount, this.total});

  PurchaseItemModel.fromMap(Map<String, dynamic> map)
      : purchaseId = map['purchaseId'],
        name = map['name'],
        qty = map['qty'],
        unit = map['unit'],
        date = map['date'],
        price = map['amount'],
        supplier = map['supplier'],
        discount = map['discount'],
        total = map['total'];
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['purchaseId'] = purchaseId;
    map['name'] = name;
    map['qty'] = qty;
    map['unit'] = unit;
    map['date'] = date;
    map['amount'] = price;
    map['supplier'] = supplier;
    map['discount'] = discount;
    map['total'] = total;
    return map;
  }

}