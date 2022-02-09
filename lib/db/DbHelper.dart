
import 'package:bar_mega/common/Utils.dart';
import 'package:bar_mega/model/Item.dart';
import 'package:bar_mega/model/Unit.dart';
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
}
class DbHelperImpl implements DbHelper{
  final Database database;
  DbHelperImpl({this.database});


  ///example
  /// db.insert(tableTodo, todo.toMap());
  /// get
  /// db.query(tableTodo,
  ///         columns: [columnId, columnDone, columnTitle],
  //         where: '$columnId = ?',
  //         whereArgs: [id]);
  //     if (maps.length > 0) {
  //       return Todo.fromMap(maps.first);
  //     }
  ///delete
  ///db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  ///update
  ///db.update(tableTodo, todo.toMap(),
  //         where: '$columnId = ?', whereArgs: [todo.id]);


  @override
  Future<int> insertData() async{
    if(database != null){
      Utils.Log("database not  null");
    }
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
    return await database.update(Sql.Item_Table, item.toMap(),where: '${Sql.Id} = ?', whereArgs: [item.itemId]);
  }

  @override
  Future<List<Map>> getMenuByCategory(String category) async{
   return await database.query(Sql.Item_Table,where: '${Sql.Category} = ?',whereArgs: [category]);
  }

  @override
  Future<int> deleteMenu(Item item) async{
    return await database.delete(Sql.Item_Table, where: '${Sql.Id} = ?', whereArgs: [item.itemId]);
  }

  @override
  Future<List<Map>> getAllTable() async{
   return await database.query(Sql.Desk_Table);
  }

}

