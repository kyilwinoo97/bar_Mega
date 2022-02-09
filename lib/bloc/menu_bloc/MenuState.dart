part of 'MenuBloc.dart';
abstract class MenuState extends Equatable{
  MenuState();
  @override
  List<Object> get props => [];
}
class Uninitialized extends MenuState{}
class Success extends MenuState{
  final List<Item> result ;
  Success({this.result});
}
class DeleteSuccess extends MenuState{
  DeleteSuccess();
}
class Failure extends MenuState{
  final String message;
  Failure(this.message);
}
class Loading extends MenuState{
  Loading();
}