import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;


class DbAccess{
  DbAccess();
  Database _database;
  Future<Database> get database async{
    if(_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }
  static int dbVersion = 1;

  Future<Database> initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path, "barMega.db");
    // bool isdbExists = await File(dbPath).exists();
    // if(!isdbExists){
    //   // Copy from asset
    //   ByteData data = await rootBundle.load(join("assets/db", "barMega.db"));
    //   List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    //
    //   // Write and flush the bytes written
    //   await File(dbPath).writeAsBytes(bytes, flush: true);
    // }

    return  openDatabase(dbPath, version: dbVersion, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate(Database db, int version) {
    for(var query in Sql.queryList){
      db.execute(query);
    }
  }

  // FutureOr<void> _onOpen(Database db) {
  //   for(var query in Sql.queryList){
  //     db.execute(query);
  //   }
  // }
}
class Sql{
  static const String NETWORK_CONFIG_TABLE = "network_config";

  static const String Item_Table = "Item";
  static const String Id = "itemId";
  static const String UnitId = "unitId";
  static const String Name = "name";
  static const String Qty = "qty";
  static const String Price = "price";
  static const String Unit = "unit";
  static const String ImagePath = "path";
  static const String Category = "category";

  static const String Desk_Table = "Desk";
  static const String D_Id = "deskId";
  static const String NO = "tableNo";
  static const String Seat = "noOfSeats";
  static const String Status = "status";


  static const String Unit_Table = "Unit";
  static const String id = "unitId";
  static const String unitName = "name";


  static const String CategoryTable = "Category";
  static const String cId = "cId";
  static const String categoryName = "name";



  static String create_unit_table ='''CREATE TABLE IF NOT EXISTS $Unit_Table 
                 ($id INTEGER PRIMARY KEY,
                  $unitName TEXT NOT NULL
                  )''';

  static String create_category_table ='''CREATE TABLE IF NOT EXISTS $CategoryTable 
                 ($cId INTEGER PRIMARY KEY,
                  $categoryName TEXT NOT NULL
                  )''';

  static String create_menu_table ='''CREATE TABLE IF NOT EXISTS $Item_Table 
                 ($Id INTEGER PRIMARY KEY,
                 $UnitId INTEGER NOT NULL,
                  $Name TEXT NOT NULL,
                  $Qty TEXT NOT NULL,
                  $Price TEXT NOT NULL,
                  $Unit TEXT NOT NULL,
                  $ImagePath TEXT NOT NULL,
                  $Category TEXT NOT NULL
                  )''';

  static String create_desk_table ='''CREATE TABLE IF NOT EXISTS $Desk_Table 
                 ($D_Id INTEGER PRIMARY KEY,
                  $NO TEXT NOT NULL,
                  $Seat INTEGER NOT NULL,
                  $Status TEXT NOT NULL
                  )''';

  static List<String> queryList = [create_menu_table,create_desk_table,create_unit_table,create_category_table];

}