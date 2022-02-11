import 'package:bar_mega/model/Item.dart';
import 'package:bar_mega/model/PurchaseItemModel.dart';
import 'package:bar_mega/repository/MainRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'PurchaseEvent.dart';
part 'PurchaseState.dart';
class PurchaseBloc extends Bloc<PurchaseEvent,PurchaseState>{
  MainRepository repository;
  PurchaseBloc({
    this.repository
  }) : super(Uninitialized());

  @override
  Stream<PurchaseState> mapEventToState(PurchaseEvent event) async*{
    if(event is GetAllPurchase){
      yield* _getAllPurchase();
    }
  }

  Stream<PurchaseState> _getAllPurchase() async*{
    yield Loading();
    List<PurchaseItemModel> lst = [];
    List<Map> result =await repository.getAllPurchase();
    for(int i = 0 ; i < result.length ; i ++){
      lst.add(PurchaseItemModel.fromMap(result[i]));
    }
    if(lst.length > 0){
      yield Success(result: lst);
    }else{
      yield Failure("No purchase data");
    }
  }



}