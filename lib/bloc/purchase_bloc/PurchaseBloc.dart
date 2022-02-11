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
    }else if(event is AddPurchaseItem){
      yield* _addPurchaseItem(event.itemModel);
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
  getAllPurchaseList() async{
    List<PurchaseItemModel> lst = [];
    List<Map> result =await repository.getAllPurchase();
    for(int i = 0 ; i < result.length ; i ++){
      lst.add(PurchaseItemModel.fromMap(result[i]));
    }
    return lst;
  }

  Stream<PurchaseState> _addPurchaseItem(PurchaseItemModel itemModel) async*{
    yield Loading();
    var result = -1;
    result = await repository.addPurchase(itemModel);
    if(result > 0){
      List<PurchaseItemModel> lst = await getAllPurchaseList();
      yield Success(result: lst);
    }else{
      yield Failure("Something wrong!");
    }
  }



}