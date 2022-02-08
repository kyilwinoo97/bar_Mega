import 'package:bar_mega/db/DbHelper.dart';
import 'package:bar_mega/model/Item.dart';

abstract class MainRepository{
  Future<int> addItem(Item item);
}
class MainRepositoryImpl extends MainRepository{
  DbHelper helper;
  MainRepositoryImpl({ this.helper});

  @override
  Future<int> addItem(item) async{
    return helper.insertData();
  }

}