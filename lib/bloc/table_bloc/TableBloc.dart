import 'package:bar_mega/model/Desk.dart';
import 'package:bar_mega/model/Item.dart';
import 'package:bar_mega/repository/MainRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
    }else if(event is SaveTable){
      yield* _saveTable(event.desk);
    }else if (event is UpdateTable){
      yield* _updateTable(event.desk);
    }else if (event is DeleteTable){
      yield* _deleteTable(event.desk);
    }else if (event is DeleteInvoice){
      yield* _deleteInvoice(event.invoiceNo);
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

  Stream<TableState> _saveTable(Desk desk)  async*{
    yield Loading();
    var result = await repository.saveTable(desk);
    if(result > 0){
      yield SaveSuccess();
    }else{
      yield Failure("Something went wrong!");
    }
  }

  Stream<TableState> _updateTable(Desk desk) async*{
    yield Loading();
    var result = await repository.updateTable(desk);
    if(result > 0){
      yield SaveSuccess();
    }else{
      yield Failure("Something went wrong!");
    }
  }

  Stream<TableState> _deleteTable(Desk desk) async*{
    yield Loading();
    var result = await repository.deleteTable(desk);
    if(result > 0){
      yield SaveSuccess();
    }else{
      yield Failure("Something went wrong!");
    }
  }

 Stream<TableState> _deleteInvoice(String invoiceNo) async*{
    yield Loading();
    var result = await repository.deleteInvoice(invoiceNo);

 }




}