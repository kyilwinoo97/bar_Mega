import 'package:bar_mega/db/DbHelper.dart';
import 'package:bar_mega/model/Item.dart';
import 'package:bar_mega/model/Unit.dart';

abstract class MainRepository{
  Future<int> addItem(Item item);

  Future<int> addUnit(Unit unit);

  Future<List<Map>> getAllUnit();
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
  Future<List<Map>> getAllUnit() async{
    return await  helper.getAllUnit();

  }

}