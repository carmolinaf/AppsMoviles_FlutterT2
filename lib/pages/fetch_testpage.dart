import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class FetchTestPage extends StatefulWidget {
  FetchTestPage({Key? key}) : super(key: key);

  @override
  _FetchTestPageState createState() => _FetchTestPageState();
}

class _FetchTestPageState extends State<FetchTestPage> {
  
bool loading= true;
late String saludo;
static const link= "https://0732-190-95-124-31.ngrok.io";


_fetch () async{
  http.Response response = await http.get(Uri.parse(link+"/'api/Marcas"));
  final decoded = jsonDecode(response.body);
  setState(() {
    //saludo = decoded['marcas'][1];
    saludo = response.statusCode.toString();
    loading= false;
  });
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: 
          loading? TextButton(onPressed: _fetch, child: Text("Cargando..",))
          :Text(saludo)
        ) 
      )
    );
  }
}