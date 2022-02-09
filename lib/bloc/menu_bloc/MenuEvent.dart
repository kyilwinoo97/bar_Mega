part of 'MenuBloc.dart';
abstract class MenuEvent extends Equatable{
MenuEvent();
@override
List<Object> get props => [];
}
class GetMenuByCategory extends MenuEvent{
  final String category;
  GetMenuByCategory(this.category);
}
class GetAllMenu extends MenuEvent{
  GetAllMenu();
}
class DeleteMenu extends MenuEvent{
  final Item item;
  DeleteMenu(this.item);
}
