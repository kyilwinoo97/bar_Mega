import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home/home.dart';
import 'injection_container.dart' as di;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  // runApp(MultiBlocProvider(providers: [
  //   BlocProvider<BaccaratBloc>(
  //     create: (BuildContext context) => di.sl<BaccaratBloc>(),
  //   ),
  //   BlocProvider<NetworkBloc>(create: (BuildContext context) =>di.sl<NetworkBloc>(),)
  // ], child:MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
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
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

