import 'package:bar_mega/model/Desk.dart';
import 'package:bar_mega/model/Item.dart';
import 'package:bar_mega/repository/MainRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'TableEvent.dart';
part 'TableState.dart';
class TableBloc extends Bloc<TableEvent,TableState>{
  MainRepository repository;
  TableBloc({
    this.repository
  }) : super(Uninitialized());

  @override
  Stream<TableState> mapEventToState(TableEvent event) async*{
    if(event is GetAllTable){
      yield* _getAllTable();
    }
  }

  Stream<TableState> _getAllTable() async*{
    yield Loading();
    List<Desk> lst = [];
    List<Map> result = await repository.getAlTable();
    for(int i = 0 ; i< result.length ; i++){
      lst.add(Desk.fromMap(result[i]));
    }
    if(lst.length > 0){
      yield Success(result: lst);
    }else{
      yield Failure("No Tables");
    }
  }



}