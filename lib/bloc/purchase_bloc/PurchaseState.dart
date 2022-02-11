part of 'PurchaseBloc.dart';

abstract class PurchaseState extends Equatable{
  PurchaseState();
  @override
  List<Object> get props => [];
}
class Uninitialized extends PurchaseState{}
class Success extends PurchaseState{
  final List<PurchaseItemModel> result ;
  Success({this.result});
}
class Failure extends PurchaseState{
  final String message;
  Failure(this.message);
}
class Loading extends PurchaseState{
  Loading();
}