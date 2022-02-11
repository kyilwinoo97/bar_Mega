
import 'package:bar_mega/common/Utils.dart';
import 'package:bar_mega/model/Desk.dart';
import 'package:bar_mega/model/Invoice.dart';
import 'package:bar_mega/model/Item.dart';
import 'package:bar_mega/model/Order.dart';
import 'package:bar_mega/model/Unit.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:sqflite/sqflite.dart';

import 'DbAccess.dart';

abstract class DbHelper{
  Future<int> insertData();
  Future close();

  Future<int> insertUnit(Unit unit);

  Future<List<Map>> getAllUnit();

  Future<int> insertMenu(Item item);

  Future<List<Map>> getAllMenu();

  Future<int> updateMenu(Item item);

  Future<List<Map>> getMenuByCategory(String category);

  Future<int> deleteMenu(Item item);

  Future<List<Map>> getAllTable();

  Future<int> insertTable(Desk desk);

  Future<int> updateTable(Desk desk);

  Future<int> deleteTable(Desk desk);

  Future<int> insertInvoice(Invoice invoice);

 Future<List<Map>> getOrderByInvoiceNo(String invoiceNo);

  Future<int> addOrder(Order order);

  Future<int> updateOrder(Order order);

  Future<List<Map>> getAllPurchase();

  Future<int> deleteOrder(Order order);

  Future<int> deleteInvoice(String invoiceNo);

  Future<int> addSale(Sale sale);
}
class DbHelperImpl implements DbHelper{
  final Database database;
  DbHelperImpl({this.database});


  @override
  Future<int> insertData() async{
    // if(database != null){
    //   Utils.Log("database not  null");
    // }
     return -1;
  }

  @override
  Future close() async => database.close();

  @override
  Future<int> insertUnit(Unit unit) async{
   return database.insert(Sql.Unit_Table, unit.toMap());
  }

  @override
  Future<List<Map>> getAllUnit() async{
 var result = await database.query(Sql.Unit_Table);
 return result;
  }

  @override
  Future<int> insertMenu(Item item) async{
    return database.insert(Sql.Item_Table, item.toMap());
  }

  @override
  Future<List<Map>> getAllMenu() async{
   return await database.query(Sql.Item_Table);
  }

  @override
  Future<int> updateMenu(Item item) async{
    return await database.update(Sql.Item_Table, item.toMap(),where: '${Sql.itemId} = ?', whereArgs: [item.itemId]);
  }

  @override
  Future<List<Map>> getMenuByCategory(String category) async{
   return await database.query(Sql.Item_Table,where: '${Sql.Category} = ?',whereArgs: [category]);
  }

  @override
  Future<int> deleteMenu(Item item) async{
    return await database.delete(Sql.Item_Table, where: '${Sql.itemId} = ?', whereArgs: [item.itemId]);
  }

  @override
  Future<List<Map>> getAllTable() async{
   return await database.query(Sql.Desk_Table);
  }

  @override
  Future<int> insertTable(Desk desk) async{
   return await database.insert(Sql.Desk_Table, desk.toMap());
  }

  @override
  Future<int> updateTable(Desk desk) async{
  return await database.update(Sql.Desk_Table, desk.toMap(),where:'${Sql.DeskId} = ?',whereArgs: [desk.deskId]);
  }

  @override
  Future<int> deleteTable(Desk desk) async{
   return await database.delete(Sql.Desk_Table,where: '${Sql.DeskId} = ?',whereArgs: [desk.deskId]);
  }

  @override
  Future<int> insertInvoice(Invoice invoice) async{
   return await database.insert(Sql.Invoice_Table, invoice.toMap());
  }

  @override
  Future<List<Map>> getOrderByInvoiceNo(String invoiceNo) async{
    return await database.query(Sql.OrderTable,where:'${Sql.invoiceNo} = ?',whereArgs: [invoiceNo]);
  }

  @override
 Future<int> addOrder(Order order) async{
   return await database.insert(Sql.OrderTable, order.toMap());
  }

  @override
 Future<int> updateOrder(Order order) async{
    return await database.update(Sql.OrderTable,order.toMap(),where:'${Sql.orderId} = ?',whereArgs: [order.orderId]);
  }

  @override
  Future<List<Map>> getAllPurchase() async{
    return await database.query(Sql.Purchase_Table);
  }

  @override
  Future<int> deleteOrder(Order order) async{
    return await database.delete(Sql.OrderTable,where: '${Sql.orderId} = ?',whereArgs: [order.orderId]);
  }

  @override
  Future<int> deleteInvoice(String invoiceNo) async{
    return await database.delete(Sql.Invoice_Table,where: '${Sql.invoiceNo} = ?',whereArgs: [invoiceNo]);
  }

  @override
  Future<int> addSale(Sale sale) async{
   return await database.insert(Sql.SaleTable, sale.toMap());
  }

}

