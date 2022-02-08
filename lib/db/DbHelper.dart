

import 'package:bar_mega/common/Utils.dart';
import 'package:sqflite/sqflite.dart';

abstract class DbHelper{
  Future<int> insertData();
  Future close();
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



}