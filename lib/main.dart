import 'package:bar_mega/bloc/menu_bloc/MenuBloc.dart';
import 'package:bar_mega/bloc/purchase_bloc/PurchaseBloc.dart';
import 'package:bar_mega/bloc/sale_bloc/SaleBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/table_bloc/TableBloc.dart';
import 'home/home.dart';
import 'injection_container.dart' as di;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
  di.init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<MenuBloc>(
      create: (BuildContext context) => di.sl<MenuBloc>(),
    ),
    BlocProvider<TableBloc>(
      create: (BuildContext context) => di.sl<TableBloc>(),
    ),
    BlocProvider<SaleBloc>(
      create: (BuildContext context) => di.sl<SaleBloc>(),
    ),
    BlocProvider<PurchaseBloc>(
      create: (BuildContext context) => di.sl<PurchaseBloc>(),
    ),
  ], child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return MaterialApp(
      title: 'Bar Mega',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: "Roboto"
      ),
      home: Home(),
    );
  }
}
