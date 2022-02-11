part of 'TableBloc.dart';
abstract class TableEvent extends Equatable{
  TableEvent();
  @override
  List<Object> get props => [];
}
class GetAllTable extends TableEvent{
  GetAllTable();
}
class SaveTable extends TableEvent{
  final Desk desk;
  SaveTable(this.desk);
}
class UpdateTable extends TableEvent{
  final Desk desk;
  UpdateTable(this.desk);
}
class DeleteTable extends TableEvent{
  final Desk desk;
  DeleteTable(this.desk);
}
class DeleteInvoice extends TableEvent{
  final String invoiceNo;
  DeleteInvoice(this.invoiceNo);
}
