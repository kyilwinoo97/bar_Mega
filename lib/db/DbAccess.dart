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
  static const String itemId = "itemId";
  static const String Name = "name";
  // static const String nameMyan = "nameMyan";
  // static const String printName = "printName";
  static const String Price = "price";
  static const String Unit = "unit";
  static const String ImagePath = "path";
  static const String Category = "category";

  static const String Desk_Table = "Desk";
  static const String DeskId = "deskId";
  static const String NO = "tableNo";
  static const String Seat = "noOfSeats";
  static const String Status = "status";

  static const String OrderTable = "OrderTable";
  static const String orderId = "orderId";
  static const String invoiceNo = "invoiceNo";
  //itemid
  static const String Quantity = "quantity";
  static const String Amount = "amount";
  static const String Discount = "discount";
  static const String Date = "date";
  static const String Total = "total";


  static const String SaleTable = "SaleTable";
  static const String saleId = "saleId";
  //invoiceId
  //amount
  //doscount
  //date
  //total




  static const String Purchase_Table = "PurchaseTable";
  static const String PurchaseId = "purchaseId";
  static const String PurchaseName = "name";
  static const String PurchaseUnit = "unit";
  static const String PurchaseAmount = "amount";
  static const String PurchaseQuantity = "qty";
  static const String Supplier = "supplier";
  static const String PurchaseDiscount = "discount";
  static const String PurchaseTotal = "total";
  static const String PurchaseDate = "date";

  static String create_purchase_table ='''CREATE TABLE IF NOT EXISTS $Purchase_Table 
                 ($PurchaseId INTEGER PRIMARY KEY,
                  $PurchaseName TEXT NOT NULL, 
                  $PurchaseUnit TEXT, 
                  $PurchaseAmount TEXT NOT NULL, 
                  $PurchaseQuantity TEXT NOT NULL, 
                  $Supplier TEXT NOT NULL, 
                  $PurchaseDiscount TEXT NOT NULL, 
                  $PurchaseDate TEXT NOT NULL, 
                  $PurchaseTotal TEXT NOT NULL 
                  )''';


  static const String PurchaseItem = "PurchaseItem";
  static const String PurchaseItemId = "purchaseItemId";
  static const String PurchaseItemName = "name";
  static const String PurchaseItemPrice = "price";
  static const String PurchaseItemUnit = "unit";
  static const String PurchaseItemSupplier = "supplier";

  static String create_purchase_Item_table ='''CREATE TABLE IF NOT EXISTS $PurchaseItem 
                 ($PurchaseItemId INTEGER PRIMARY KEY,
                  $PurchaseItemName TEXT NOT NULL, 
                  $PurchaseItemPrice TEXT NOT NULL, 
                  $PurchaseItemUnit TEXT NOT NULL, 
                  $PurchaseItemSupplier TEXT NOT NULL
                  )''';

  static const String Invoice_Table = "InvoiceTable";


  static const String CategoryTable = "Category";
  static const String cId = "cId";
  static const String categoryName = "name";


  static const String Unit_Table = "Unit";
  static const String id = "unitId";
  static const String unitName = "name";

  static String create_unit_table ='''CREATE TABLE IF NOT EXISTS $Unit_Table 
                 ($id INTEGER PRIMARY KEY,
                  $unitName TEXT NOT NULL
                  )''';

  static const String UnitSaleTable = "SaleUnit";
  static const String SaleUnitId = "unitId";
  static const String SaleUnitName = "name";

  static String create_sale_unit_table ='''CREATE TABLE IF NOT EXISTS $UnitSaleTable 
                 ($SaleUnitId INTEGER PRIMARY KEY,
                  $SaleUnitName TEXT NOT NULL
                  )''';

  static String create_category_table ='''CREATE TABLE IF NOT EXISTS $CategoryTable 
                 ($cId INTEGER PRIMARY KEY,
                  $categoryName TEXT NOT NULL
                  )''';

  static String create_invoice_table ='''CREATE TABLE IF NOT EXISTS $Invoice_Table 
                 ($invoiceNo INTEGER PRIMARY KEY,
                  $DeskId INTEGER NOT NULL
                  )''';



  static String create_order_table ='''CREATE TABLE IF NOT EXISTS $OrderTable 
                 ($orderId INTEGER PRIMARY KEY,
                  $invoiceNo TEXT NOT NULL,
                  $Name TEXT NOT NULL,
                  $Quantity INTEGER NOT NULL,
                  $Amount TEXT NOT NULL,
                  $Discount TEXT NOT NULL,
                  $Unit TEXT NOT NULL,
                  $Date TEXT NOT NULL,
                  $Total TEXT NOT NULL
                  )''';

  static String create_sale_table ='''CREATE TABLE IF NOT EXISTS $SaleTable 
                 ($saleId INTEGER PRIMARY KEY,
                  $invoiceNo TEXT NOT NULL,
                  $Name TEXT NOT NULL,
                  $Quantity INTEGER NOT NULL,
                  $Amount TEXT NOT NULL,
                  $Discount TEXT NOT NULL,
                  $Date TEXT NOT NULL,
                  $Total TEXT NOT NULL
                  )''';

  static String create_menu_table ='''CREATE TABLE IF NOT EXISTS $Item_Table 
                 ($itemId INTEGER PRIMARY KEY,
                  $Name TEXT NOT NULL,
                  $Price TEXT NOT NULL,
                  $Unit TEXT NOT NULL,
                  $ImagePath TEXT NOT NULL,
                  $Category TEXT NOT NULL
                  )''';

  static String create_desk_table ='''CREATE TABLE IF NOT EXISTS $Desk_Table 
                 ($DeskId INTEGER PRIMARY KEY,
                  $NO TEXT NOT NULL,
                  $Seat INTEGER NOT NULL,
                  $invoiceNo TEXT NOT NULL,
                  $Status TEXT NOT NULL
                  )''';

  static List<String> queryList = [create_invoice_table,create_menu_table,create_desk_table,create_sale_table,create_order_table,create_purchase_table,create_purchase_Item_table,create_sale_unit_table,create_unit_table];

}