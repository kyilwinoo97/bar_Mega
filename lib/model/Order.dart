import 'Item.dart';

class Order{
  int orderId;
  String invoiceNo;
  String itemName;
  int qty;
  String price;
  String discount;
  String date;
  Item item;

}
class Sale{
  int saleId;
  String invoiceNo;
  String price;
  String date;
  String discount;
  String total;
}