import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nuevo_intento/Models/auto.dart';

import '../db.dart';



class ListadoPage extends StatefulWidget {
  const ListadoPage({Key? key}) : super(key: key);

  @override
  _ListadoPageState createState() => _ListadoPageState();
}

class _ListadoPageState extends State<ListadoPage> {

  List<Auto> autos= [];

  cargaAutos() async {
    List<Auto> auxAutos = await DB.getAutos();
    setState(() {
      autos = auxAutos;
    });
  }

  @override
  void initState() {
    cargaAutos();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Borrador Automóviles"),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                itemCount: autos.length,
                itemBuilder: (context, i) => ListItem(autos[i])
              ),
            ),
            const SizedBox(height: 10,),
            _botonEnviar(),
            const SizedBox(height: 20,)
          ],
        )
      ),
    );
  }

  Widget ListItem(Auto auto){
  /*
  const ListItem({
    required this.auto,
    Key? key
  }) : super(key: key);
  
  final Auto auto;
  */

  return ListTile(
  
    isThreeLine: true,
    title: Text("Patente: "+ auto.patente),
    subtitle: Text("Marca: "+ auto.marca + "\nPrecio: " + auto.precio.toString()),
    trailing:  IconButton(
      icon: const Icon(Icons.cancel_outlined),
      iconSize: 32.0,
      onPressed: () => setState(() {
        DB.delete(auto.id!);
        cargaAutos();
      }),
    ),

  );
}

  Widget _botonEnviar() {
    return ElevatedButton(
      onPressed: () {
         Navigator.pushNamed(context, 'login_page');
      },
      child: Container(
        width: 150,
        child: const Center(
         child: Text("Enviar al servidor"),
       )
      )
    );
  }
}

