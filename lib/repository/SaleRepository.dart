import 'package:bar_mega/db/DbHelper.dart';
import 'package:bar_mega/model/Invoice.dart';
import 'package:bar_mega/model/Order.dart';
import 'package:bar_mega/sale/SaleList.dart';

abstract class SaleRepository{
 Future<List<Map>> getAllSale();

Future<int> addInvoice(Invoice invoice);


Future<List<Map>> getAllOrderByInvoiceNo(String invoiceNo);

 Future<int> updateOrder(Order order);

 Future<int> addOrder(Order order);

 Future<int> deleteOrder(Order order);

 Future<int> addSale(Sale sale);
}
class SaleRepositoryImpl extends SaleRepository{
  DbHelper helper;
  SaleRepositoryImpl({ this.helper});

  @override
  Future<List<Map>> getAllSale() async{
    return await helper.getAllSale();
  }

  @override
  Future<int> addInvoice(Invoice invoice) async{
  return await helper.insertInvoice(invoice);
  }

  @override
  Future<List<Map>> getAllOrderByInvoiceNo(String invoiceNo) async{
    return await helper.getOrderByInvoiceNo(invoiceNo);
  }

  @override
  Future<int> addOrder(Order order) async{
  return await helper.addOrder(order);
  }

  @override
  Future<int> updateOrder(Order order) async{
   return await helper.updateOrder(order);

  }

  @override
  Future<int> deleteOrder(Order order) async{
    return await helper.deleteOrder(order);
  }

  @override
  Future<int> addSale(Sale sale) async{
    return await helper.addSale(sale);
  }
}