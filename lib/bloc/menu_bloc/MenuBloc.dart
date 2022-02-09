import 'package:bar_mega/model/Item.dart';
import 'package:bar_mega/repository/MainRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'MenuEvent.dart';
part 'MenuState.dart';
class MenuBloc extends Bloc<MenuEvent,MenuState>{
  MainRepository repository;
  MenuBloc({
    this.repository
  }) : super(Uninitialized());

  @override
  Stream<MenuState> mapEventToState(MenuEvent event) async*{
    if(event is GetAllMenu){
      yield* _getAllMenu();
    }else if(event is GetMenuByCategory){
      yield* _getMenuByCategory(event.category);
    }else if(event is DeleteMenu){
      yield* _deleteMenu(event.item);
    }
  }

 Stream<MenuState> _getAllMenu() async*{
   yield Loading();
   List<Item> lst = [];
   List<Map> result = await repository.getAllMenu();
   for(int i = 0 ; i< result.length ; i++){
     lst.add(Item.fromMap(result[i]));
   }
   if(lst.length > 0){
     yield Success(result: lst);
   }else{
     yield Failure("No Menu Item");
   }
 }

 Stream<MenuState> _getMenuByCategory(String category) async*{
    yield Loading();
    List<Item> lst = [];
    List<Map> result = await repository.getMenuByCategory(category);
    for(int i = 0 ; i< result.length ; i++){
      lst.add(Item.fromMap(result[i]));
    }
    if(lst.length > 0){
      yield Success(result: lst);
    }else{
      yield Failure("No Menu Item");
    }

 }

  Stream<MenuState> _deleteMenu(Item item) async*{
    yield Loading();
    var result = await repository.deleteMenu(item);
    if(result > 0){
      yield DeleteSuccess();
    }else{
      yield Failure("Something went wrong!");
    }
  }


}