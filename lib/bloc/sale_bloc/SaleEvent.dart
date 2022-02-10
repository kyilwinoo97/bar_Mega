part of 'SaleBloc.dart';
abstract class SaleEvent extends Equatable{
  SaleEvent();
  @override
  List<Object> get props => [];
}
class AddOrder extends SaleEvent{
  AddOrder();
}