
import 'dart:convert';

import 'package:bar_mega/common/Utils.dart';
import 'package:bar_mega/model/Desk.dart';
import 'package:bar_mega/model/Invoice.dart';
import 'package:bar_mega/model/Item.dart';
import 'package:bar_mega/model/Order.dart';
import 'package:bar_mega/model/PurchaseItemModel.dart';
import 'package:bar_mega/model/Unit.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:encrypt/encrypt.dart';
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

  Future<int> insertPurchase(PurchaseItemModel itemModel);

  Future<List<Map>> getAllSale();

  Future<String>generateBackup({bool isEncrypted = true});

  Future<void>restoreBackup(String backup,{ bool isEncrypted = true});

}
class DbHelperImpl implements DbHelper{
  final Database database;
  DbHelperImpl({this.database});
  String SECRET_KEY = "2514879314527865";
  String SECRET_IV = "2389451725810357";


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

  @override
  Future<int> insertPurchase(PurchaseItemModel item) async{
   return await database.insert(Sql.Purchase_Table, item.toMap());
  }

  @override
  Future<List<Map>> getAllSale() async{
    return await database.query(Sql.SaleTable);
  }

  @override
  Future<String>generateBackup({bool isEncrypted = true}) async {

    print('GENERATE BACKUP');

    var dbs = await database;

    List data =[];

    List<Map<String,dynamic>> listMaps=[];

    for (var i = 0; i < Sql.tables.length; i++)
    {

      listMaps = await dbs.query(Sql.tables[i]);

      data.add(listMaps);

    }

    List backups=[Sql.tables,data];

    String json = jsonEncode(backups);

    if(isEncrypted)
    {

      var key = Key.fromUtf8(SECRET_KEY);
      var iv = IV.fromUtf8(SECRET_IV);
      var encrypter = Encrypter(AES(key,mode: AESMode.cbc,padding: 'PKCS7'));
      var encrypted = encrypter.encrypt(json, iv: iv);
      return encrypted.base64;
    }
    else
    {
      return json;
    }
  }

  @override
  Future<void>restoreBackup(String backup,{ bool isEncrypted = true}) async {

    var dbs = await database;

    Batch batch = dbs.batch();

    final key = Key.fromUtf8(SECRET_KEY);
    final iv = IV.fromUtf8(SECRET_IV);
    var encrypter = Encrypter(AES(key,mode: AESMode.cbc,padding: 'PKCS7'));

    List json = jsonDecode(isEncrypted ? encrypter.decrypt64(backup,iv:iv):backup);

    for (var i = 0; i < json[0].length; i++)
    {
      for (var k = 0; k < json[1][i].length; k++)
      {
        batch.insert(json[0][i],json[1][i][k]);
      }
    }

    await batch.commit(continueOnError:false,noResult:true);

    print('RESTORE BACKUP');
  }


}

