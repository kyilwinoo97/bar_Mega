import 'Item.dart';

class Order{
  int orderId;
  String invoiceNo;
  String name;
  int quantity;
  String amount;
  String discount;
  String date;
  String total;
  String unit;

  Order({this.orderId, this.invoiceNo, this.name, this.quantity, this.amount,
      this.discount,this.unit, this.date, this.total});
  Order.fromMap(Map<String, dynamic> map)
      : orderId = map['orderId'],
       invoiceNo = map['invoiceNo'],
        name = map['name'],
        quantity = map['quantity'],
        amount = map['amount'],
        unit = map['unit'],
        discount = map['discount'],
        date = map['date'],
        total = map['total'];

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['orderId'] = orderId;
    map['invoiceNo'] = invoiceNo;
    map['name'] = name;
    map['quantity'] = quantity;
    map['amount'] = amount;
    map['unit'] = unit;
    map['discount'] = discount;
    map['date'] = date;
    map['total'] = total;
    return map;
  }
}

class OrderList{
  static List<Order> list;
  set setList(List<Order> orders) => list = orders;
  get getList => list;
}

class Sale{
  int saleId;
  String invoiceNo;
  String name;
  int quantity;
  String amount;
  String discount;
  String date;
  String total;

  Sale({this.saleId, this.invoiceNo, this.name, this.quantity, this.amount,
      this.discount, this.date, this.total});

  Sale.fromMap(Map<String, dynamic> map)
      : saleId = map['saleId'],
        invoiceNo = map['invoiceNo'],
        name = map['name'],
        quantity = map['quantity'],
        amount = map['amount'],
        discount = map['discount'],
        date = map['date'],
        total = map['total'];

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['saleId'] = saleId;
    map['invoiceNo'] = invoiceNo;
    map['name'] = name;
    map['quantity'] = quantity;
    map['amount'] = amount;
    map['discount'] = discount;
    map['date'] = date;
    map['total'] = total;
    return map;
  }

}