import 'package:bar_mega/model/Item.dart';
import 'package:bar_mega/model/Order.dart';
import 'package:bar_mega/repository/MainRepository.dart';
import 'package:bar_mega/repository/SaleRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'SaleState.dart';
part 'SaleEvent.dart';

class SaleBloc extends Bloc<SaleEvent,SaleState> {
  SaleRepository repository;

  SaleBloc({
    this.repository
  }) : super(Uninitialized());

  @override
  Stream<SaleState> mapEventToState(SaleEvent event) async*{
   if(event is AddOrder){
     yield* _addAllOrder(event.order);
   }else if (event is GetOrderByInvoice){
     yield* _getOrderByInvoice(event.invoiceNo);
   }else if (event is RemoveOneOrder){
     yield* _removeOneOrder(event.order);
   }else if(event is RemoveAllOrder){
     yield* _removeAllOrder(event.lstOrder);
   }else if(event is AddSale){
     yield* _addSale(event.sale);
   }else if(event is AddOneOrder){
     yield* _addOneOrder(event.order);
   }else if(event is UpdateOrder){
     yield* _updateOrder(event.order);
   }else if(event is GetAllSale){
     yield* _getAllSale();
   }
  }


  Stream<SaleState> _getOrderByInvoice(String invoiceNo) async*{
    yield Loading();
    List<Order> lst = [];
    var result =await  repository.getAllOrderByInvoiceNo(invoiceNo);
    for(int i = 0 ; i< result.length; i ++){
      lst.add(Order.fromMap(result[i]));
    }
    if(lst.length > 0){
      yield Success(result:  lst);
    }else{
      Failure("No Item");
    }
  }
  Future<List<Order>> getOrderByInvoice(String invoice) async{
    List<Order> lst = [];
    var result =await  repository.getAllOrderByInvoiceNo(invoice);
    for(int i = 0 ; i< result.length; i ++){
      lst.add(Order.fromMap(result[i]));
    }
    return lst;
  }
  Stream<SaleState>  _addOneOrder(Order order) async*{
    yield Loading();
    var result = -1;
    result =await repository.addOrder(order);
    if(result > 0){
      List<Order> lst = await getOrderByInvoice(order.invoiceNo);
      yield Success(result: lst);
    }else {
      Failure("Order Add failed!");
    }
  }
  Stream<SaleState> _updateOrder(Order order) async*{
    yield Loading();
    var result = -1;
    result =await repository.updateOrder(order);
    if(result > 0){
      List<Order> lst = await getOrderByInvoice(order.invoiceNo);
      yield Success(result: lst);
    }else {
      Failure("Order Update failed!");
    }
  }


  Stream<SaleState> _removeOneOrder(Order order) async*{
    yield Loading();
    var result =await repository.deleteOrder(order);
    if(result > 0){
      List<Order> lst = await getOrderByInvoice(order.invoiceNo);
      yield Success(result: lst);
    }else{
      Failure("Something went wrong");
    }
 }

 Stream<SaleState> _addAllOrder(List<Order> order) async*{
    yield Loading();
    var result;
    for(int i = 0 ;i < order.length ; i ++){
      if(order[i].orderId != null){
        //update
        result = await repository.updateOrder(order[i]);

      }else{
        //insert
        result =await repository.addOrder(order[i]);
      }
      if(result < 0){
        break;
      }
    }
    if(result > 0){
      yield Success();
    }else{
      yield Failure("Something went wrong");
    }

  }

  Stream<SaleState> _removeAllOrder(List<Order> lstOrder) async*{
    yield Loading();
    var result = -1;
    for(int i = 0 ; i < lstOrder.length ; i++){
      result = await repository.deleteOrder(lstOrder[i]);
      if(result < 0){
        break;
      }
      if(result > 0){
        yield DeleteSuccess();
      }else{
        yield Failure("Something went wrong");
      }
    }
  }

  Stream<SaleState> _addSale(Sale sale) async*{
    yield Loading();
    var result = -1;
    result = await repository.addSale(sale);
    if(result > 0){
      yield SaleSuccess();
    }else{
      yield Failure("Something went wrong");
    }
  }
  Stream<SaleState> _getAllSale() async*{
    yield Loading();
    List<Sale> lst = [];
    List<Sale> result = await repository.getAllSale();
    for(int i = 0 ; i< result.length ; i++){
      lst.add(result[i]);
    }
    if(lst.length > 0){
      yield AllSaleSuccess(result: lst);
    }else{
      yield Failure("No Sales");
    }
  }
}
