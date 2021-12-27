import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nuevo_intento/Models/persona.dart';

class PersonaServices{
  Future<List<Persona>> getAll() async{
    final url = Uri.parse("https://c321-190-95-124-31.ngrok.io/api/Personas");

    var result = await http.get(url);

    if (result.statusCode==200){
      print(result.body);
      List<dynamic> body = jsonDecode(result.body);
      List<Persona> personas =
           body.map((dynamic item)=> Persona.fromJson(item)).toList();
      return personas;
    }else{
      throw "Error no se puede leer desde la api";
    }
  }

Future<bool> delete(int id) async{
    final url = Uri.parse(
      "https://c321-190-95-124-31.ngrok.io/api/Personas" + id.toString());
    var result = await http.delete(url);

    if (result.statusCode==200){
      return true;
    }else{
      throw "Error no se puede leer desde la api";
    }
}

  Future<Persona> createPersona( 
    String nombre, String apellido, int edad) async {
    final url = Uri.parse("https://c321-190-95-124-31.ngrok.io/api/Personas");

    final response = await http.post(
      url,
      headers: <String, String>{
      'Content-type': 'application/json;charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nombre':nombre, 
        'apellido':apellido,
        'edad':edad.toString(),
      }),
    );

    if(response.statusCode==200){
      return Persona.fromJson(jsonDecode(response.body));
    }else{
      throw "Error no se pudo guardar";
    }
  }
}
