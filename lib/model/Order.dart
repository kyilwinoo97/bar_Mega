import 'Item.dart';

class Order{
  int orderId;
  String invoiceNo;
  String itemName;
  int qty;
  String price;
  String discount;
  String date;
  String total;
  Order({this.itemName,this.qty,this.price,this.total});
}

class OrderList{
  static List<Order> list;
  set setList(List<Order> orders) => list = orders;
  get getList => list;
}

class Sale{
  int saleId;
  String invoiceNo;
  String price;
  String date;
  String discount;
  String total;
}