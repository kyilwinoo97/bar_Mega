import 'package:bar_mega/db/DbHelper.dart';
import 'package:bar_mega/model/Desk.dart';
import 'package:bar_mega/model/Item.dart';
import 'package:bar_mega/model/PurchaseItemModel.dart';
import 'package:bar_mega/model/Unit.dart';

abstract class MainRepository{
  Future<int> addItem(Item item);

  Future<int> addUnit(Unit unit);

  Future<int> saveMenu(Item item);

  Future<List<Map>> getAllMenu();

  Future<int> updateMenu(Item item);

  Future<List<Map>> getMenuByCategory(String category);

  Future<int> deleteMenu(Item item);

  Future<List<Map>> getAlTable();

  Future<int> saveTable(Desk desk);

  Future<int> updateTable(Desk desk);

  Future<int> deleteTable(Desk desk);

  Future<List<Map>> getAllPurchase();

  Future<int> deleteInvoice(String invoiceNo);

  Future<int> addPurchase(PurchaseItemModel itemModel);
}
class MainRepositoryImpl extends MainRepository{
  DbHelper helper;
  MainRepositoryImpl({ this.helper});

  @override
  Future<int> addItem(item) async{
    return helper.insertData();
  }

  @override
  Future<int> addUnit(Unit unit) {
    return helper.insertUnit(unit);
  }

  @override
  Future<int> saveMenu(Item item) async{
  return await helper.insertMenu(item);
  }

  @override
  Future<List<Map>> getAllMenu() async{
  return await helper.getAllMenu();
  }

  @override
  Future<int> updateMenu(Item item) async{
   return await helper.updateMenu(item);
  }

  @override
  Future<List<Map>> getMenuByCategory(String category) async{
    return await helper.getMenuByCategory(category);
  }

  @override
  Future<int> deleteMenu(Item item) async{
    return await helper.deleteMenu(item);

  }

  @override
  Future<List<Map>> getAlTable() async{
  return await helper.getAllTable();
  }

  @override
  Future<int> saveTable(Desk desk) async{
   return await helper.insertTable(desk);
  }

  @override
  Future<int> updateTable(Desk desk) async{
   return await helper.updateTable(desk);
  }

  @override
  Future<int> deleteTable(Desk desk) async{
   return await helper.deleteTable(desk);
  }

  @override
  Future<List<Map>> getAllPurchase() async{
   return await helper.getAllPurchase();
  }

  @override
  Future<int> deleteInvoice(String invoiceNo) async{
   return await helper.deleteInvoice(invoiceNo);
  }

  @override
  Future<int> addPurchase(PurchaseItemModel itemModel) async{
   return await helper.insertPurchase(itemModel);
  }

}
