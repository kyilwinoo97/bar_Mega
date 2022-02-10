import 'Item.dart';

class Order{
  int orderId;
  int tableId;
  String invoiceNo;
  String tablesNo;
  String itemName;
  String price;
  String discount;
  String date;
  int qty;
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