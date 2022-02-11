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
  List<Order> lstOrder = [];

  SaleBloc({
    this.repository
  }) : super(Uninitialized());

  @override
  Stream<SaleState> mapEventToState(SaleEvent event) async*{
   if(event is AddOrder){
     yield* _addAllOrder(event.order);
   }else if(event is ClearOrder){
     yield* clearOrder();
   }else if (event is GetOrderByInvoice){
     yield* _getOrderByInovice(event.invoiceNo);
   }else if (event is RemoveOneOrder){
     yield* _removeOneOrder(event.order);
   }
  }

  Stream<SaleState> _addOrder(Order order) async*{
    yield Loading();
    int itemIndex = lstOrder
        .indexWhere((e) => e.name == order.name);
    if(itemIndex == -1){
      lstOrder.add(order);
      print("add list => ${lstOrder.length}");
    }else{
      lstOrder[itemIndex].quantity += order.quantity;
      lstOrder[itemIndex].total =  (double.parse(lstOrder[itemIndex].total) + double.parse(order.total)).toString();
      print("list update =>${lstOrder.length}");
    }
    yield Success(result: lstOrder);
  }

  Stream<SaleState> clearOrder() async*{
    yield Loading();
    lstOrder.clear();
    yield Success(result:  lstOrder);
  }

  Stream<SaleState> _getOrderByInovice(String invoiceNo) async*{
    yield Loading();
    // var result = repository.getAllOrderByInvoiceNo(invoiceNo);
    // for(int i = 0 ; i< result.length; i ++){
    //   lstOrder.add(Ord)
    // }
    yield Success(result:  lstOrder);
  }

 Stream<SaleState> _removeOneOrder(Order order) async*{
    yield Loading();
    lstOrder.removeAt(lstOrder.indexOf(order));
    print("lstOrder lengt ${lstOrder.length}");
    yield Success(result: lstOrder);
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


}
