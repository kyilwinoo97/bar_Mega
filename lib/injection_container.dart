import 'package:bar_mega/bloc/menu_bloc/MenuBloc.dart';
import 'package:bar_mega/bloc/purchase_bloc/PurchaseBloc.dart';
import 'package:bar_mega/bloc/sale_bloc/SaleBloc.dart';
import 'package:bar_mega/repository/MainRepository.dart';
import 'package:bar_mega/repository/SaleRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/table_bloc/TableBloc.dart';
import 'db/DbAccess.dart';
import 'db/DbHelper.dart';

final sl = GetIt.instance;
Future<void> init() async{

  sl.registerFactory(() => MenuBloc(repository: sl()));
  sl.registerFactory(() => TableBloc(repository: sl()));
  sl.registerFactory(() => SaleBloc(repository: sl()));
  sl.registerFactory(() => PurchaseBloc(repository: sl()));


  //repository
  sl.registerLazySingleton<MainRepository>(() =>new MainRepositoryImpl(helper:sl()));
  sl.registerLazySingleton<SaleRepository>(() =>new SaleRepositoryImpl(helper:sl()));


  //Core
  final db = await DbAccess().database;
  sl.registerLazySingleton(() => db);
  sl.registerLazySingleton<DbHelper>(() => new DbHelperImpl(database: sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // sl.registerLazySingleton(() =>new Dio(new BaseOptions(
  //     connectTimeout: 40 * 1000,
  //     receiveTimeout: 40 * 1000,
  //     sendTimeout: 40 * 1000
  // ))..interceptors.add(PrettyDioLogger(
  //     requestHeader: true,
  //     requestBody: true,
  //     responseBody: true,
  //     responseHeader: true,
  //     error: true,
  //     compact: true,
  //     maxWidth: 90))
  // );

}