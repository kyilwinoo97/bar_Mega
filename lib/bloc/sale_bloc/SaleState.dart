part of 'SaleBloc.dart';
abstract class SaleState extends Equatable{
  SaleState();
  @override
  List<Object> get props => [];
}
class Uninitialized extends SaleState{}
class Success extends SaleState{
  final List<Order> result ;
  Success({this.result});
}
class Failure extends SaleState{
  final String message;
  Failure(this.message);
}
class Loading extends SaleState{
  Loading();
}