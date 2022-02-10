import 'package:bar_mega/db/DbHelper.dart';

abstract class SaleRepository{

}
class SaleRepositoryImpl extends SaleRepository{
  DbHelper helper;
  SaleRepositoryImpl({ this.helper});
}