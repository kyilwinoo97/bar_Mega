import 'package:bar_mega/db/DbHelper.dart';
import 'package:bar_mega/sale/Sale.dart';

abstract class SaleRepository{
 List<Sale> getAllSale();

}
class SaleRepositoryImpl extends SaleRepository{
  DbHelper helper;
  SaleRepositoryImpl({ this.helper});

  @override
  List<Sale> getAllSale() {
    // TODO: implement getAllSale
    throw UnimplementedError();
  }
}