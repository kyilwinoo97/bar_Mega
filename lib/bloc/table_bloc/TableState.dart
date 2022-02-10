part of 'TableBloc.dart';
abstract class TableState extends Equatable{
  TableState();
  @override
  List<Object> get props => [];
}
class Uninitialized extends TableState{}
class Success extends TableState{
  final List<Desk> result ;
  Success({this.result});
}
class DeleteSuccess extends TableState{
  DeleteSuccess();
}
class SaveSuccess extends TableState{
  SaveSuccess();
}
class Failure extends TableState{
  final String message;
  Failure(this.message);
}
class Loading extends TableState{
  Loading();
}