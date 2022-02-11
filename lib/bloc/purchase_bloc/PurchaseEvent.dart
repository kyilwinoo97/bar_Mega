part of 'PurchaseBloc.dart';
abstract class PurchaseEvent extends Equatable{
  PurchaseEvent();
  @override
  List<Object> get props => [];
}
class GetAllPurchase extends PurchaseEvent{
  GetAllPurchase();
}
class AddPurchaseItem extends PurchaseEvent{
  final PurchaseItemModel itemModel;
  AddPurchaseItem(this.itemModel);
}