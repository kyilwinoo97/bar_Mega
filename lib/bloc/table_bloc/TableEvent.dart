part of 'TableBloc.dart';
abstract class TableEvent extends Equatable{
  TableEvent();
  @override
  List<Object> get props => [];
}
class GetAllTable extends TableEvent{
  GetAllTable();
}
