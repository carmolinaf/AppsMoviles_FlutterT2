import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nuevo_intento/Models/auto.dart';
import '../db.dart';

class IngresoPage extends StatefulWidget {
  IngresoPage({Key? key}) : super(key: key);
  @override
  _IngresoPageState createState() => _IngresoPageState();
}

///Class to handle easier the raw http.Response
class Marcas{
  final List<String> list;
  //final int len;

  Marcas({required this.list});
  factory Marcas.fromJson(Map<String, dynamic> json){
    return Marcas(
      list: json['marcas'].cast<String>()
    );
  }
}

class _IngresoPageState extends State<IngresoPage> {
  static const link= "https://0732-190-95-124-31.ngrok.io/";
  ///Function to fetch and converting the http.Response to a Marcas class
  Future <Marcas> fetchMarcas()async{
    final http.Response response = await http
      .get(Uri.parse(link+'api/Marcas'));
    
    if(response.statusCode == 200){
       return Marcas.fromJson(jsonDecode(response.body));
    }
    else{throw Exception('Error en la operacion');}
  }

  ///Fetching the data in "initState"
  late Future<Marcas> _marcas;
  @override
  void initState() {
    super.initState();
     _marcas= fetchMarcas();
  }

  /// for the Form
  final _formkey = GlobalKey<FormState>(); //carForm 
  String _patente ="";                     //_campoPatente
  String? _marcaSelected = null;           //_marcaDropDown
  String _precio ="";                      //_campoPrecio
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //para no tener overflow cuando se despleiga el tecaldo
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title:  const Text("Información del Vehículo"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            carForm(),
            SizedBox(height: 20,),
            _botonListado(),
            _marcaSelected!=null?Text(_marcaSelected!):Text("no hay valor")
          ],
        )
      )
    );
  }

  carForm(){
    return Form(
      key: _formkey,
      child: Column(
        children: [
          _campoPatente(),
          _marcaDropDown(),
          _campoPrecio(),
          const SizedBox(height: 20,),
          _botonGuardar(),
        ],)
    );
  }

  //validacion de 4 letras y 2 numeros
  String? _patenteValidator(String str) {
    String pattern = r"[a-zA-Z]{4}\d{2}";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(str)) {
      return 'Ingrese una patente valida';
    } else {
      return null;
    }
  }

  Widget _campoPatente() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            //icon: Icon(Icons.),
            hintText: 'AAAA11',
            labelText: 'Patente:',
            ),
        validator: (value) =>_patenteValidator(value!),
        onSaved: (String? val) {
          _patente = val!;
        },
      ),
    );
  }


  Widget _marcaDropDown() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: FutureBuilder<Marcas>(
        future: _marcas,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              hint: const Text('Marca: '),
              value: null,
              items: snapshot.data!.list.map((item) => DropdownMenuItem(
                  child: Text(item),
                  value: item,
                )).toList(),
              validator: (value) => value == null ? 'Campo requerido' : null,
              onChanged: (String? value) {
                    setState(() {
                      _marcaSelected = value!;
                    });
              }
            ); 
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }


 //validacion solo numero positivos
  String? _precioValidator(String str) {
    String pattern = r"^[1-9]+[0-9]*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(str)) {
      return 'Ingrese un valor valido';
    } else {
      return null;
    }
  }

  Widget _campoPrecio() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixText: '\$  ',
            //icon: Icon(Icons.attach_money),
            hintText: 'Ingrese valor del vehículo',
            labelText: 'Precio:',
            ),
        validator: (value) => _precioValidator(value!),
        onSaved: (String? val) {
          _precio = val!;
        },
      ),
    );
  }


  Widget _botonGuardar() {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
         //DB.insert(Auto(id: 0, patente: _patente, marca: _marcaSelected!, precio: int.parse(_precio)));
         DB.insert(Auto(patente: _patente, marca: _marcaSelected!, precio: int.parse(_precio)));
         setState(() {
           _formkey.currentState?.reset();
           _patente="";
           _marcaSelected=null;
           _precio="";
         });
         Navigator.pushNamed(context, 'listado_page');
        } else {
          print("Error");
        }
      },
      child: Container(
        width: 150,
        child: const Center(
         child: Text("Guardar"),
       )
      )
    );
  }


   Widget _botonListado() {
    return ElevatedButton(
      onPressed: () {
         Navigator.pushNamed(context, 'listado_page');
      },
      child: Container(
        width: 150,
        child: const Center(
         child: Text("Listado"),
       )
      )
    );
  }

}
