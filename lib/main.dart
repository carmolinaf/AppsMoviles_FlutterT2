import 'package:flutter/material.dart';
import 'package:nuevo_intento/pages/demo2_page.dart';
import 'package:nuevo_intento/pages/fetch_testpage.dart';
import 'package:nuevo_intento/pages/ingreso_page.dart';
import 'package:nuevo_intento/pages/listado_page.dart';
import 'package:nuevo_intento/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //primarySwatch: Colors.yellow,
      ),
      //initialRoute: 'demo2_page',//OK
      //initialRoute: 'ingreso_page',
      initialRoute: 'login_page', //OK
      routes: {
        'login_page': (_) => LoginPage(),
        'ingreso_page': (_) => IngresoPage(),
        'listado_page': (_) => ListadoPage(),
        'fetch_testpage': (_) => FetchTestPage(),
        'demo2_page': (_) => Demo2Page()
      },
    );
  }
}
