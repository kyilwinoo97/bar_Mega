part of 'SaleBloc.dart';
abstract class SaleEvent extends Equatable{
  SaleEvent();
  @override
  List<Object> get props => [];
}
class AddOrder extends SaleEvent{
  final List<Order> order;
  AddOrder(this.order);
}
class ClearOrder extends SaleEvent{
  ClearOrder();
}
class GetOrderByInvoice extends SaleEvent{
  final String invoiceNo;
  GetOrderByInvoice(this.invoiceNo);
}
class RemoveOneOrder extends SaleEvent{
  final Order order;
  RemoveOneOrder(this.order);
}
class RemoveAllOrder extends SaleEvent{
  final List<Order> lstOrder;
  RemoveAllOrder(this.lstOrder);
}
class AddSale extends SaleEvent{
  final Sale sale;
  AddSale(this.sale);
}
class GetAllSale extends SaleEvent{
  GetAllSale();
}