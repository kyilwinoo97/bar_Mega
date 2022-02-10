import 'package:bar_mega/model/Item.dart';
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
     yield* _addOrder();
   }
  }

  Stream<SaleState> _addOrder() async*{
    yield Loading();
  }


}
