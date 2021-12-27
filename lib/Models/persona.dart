import 'dart:convert';

List<Persona> personaFromJson(String str) => List<Persona>.from(json.decode(str).map((x) => Persona.fromJson(x)));

String personaToJson(List<Persona> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Persona {
    Persona({
        required this.id,
        required this.nombre,
        required this.apellido,
        required this.edad,
    });

    int id;
    String nombre;
    String apellido;
    int edad;

    factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        id: json["Id"],
        nombre: json["Nombre"],
        apellido: json["Apellido"],
        edad: json["Edad"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Nombre": nombre,
        "Apellido": apellido,
        "Edad": edad,
    };
}
