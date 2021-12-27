/*
import 'package:flutter/material.dart';
import 'package:nuevo_intento/Services/persona_services.dart';

class Ingresar extends StatefulWidget {
  Ingresar({Key? key}) : super(key: key);

  @override
  _IngresarState createState() => _IngresarState();
}

class _IngresarState extends State<Ingresar> {
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final edadController = TextEditingController();
  bool guardando = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ingresar persona"),
      ),
      body: Column(
          children: [
            const Text("Ingresar Nombre"),
            TextField(
              autocorrect: false,
              controller: nombreController,
            ),
            const Text("Ingresar Apellido"),
            TextField(
              autocorrect: false,
              controller: apellidoController,
            ),
            const Text("Ingresar Edad"),
            TextField(
              autocorrect: false,
              controller: edadController,
            ),
            ElevatedButton(
              onPressed: ()async {
                setState(() {
                  guardando = true;
                });
                await PersonaServices().createPersona(nombreController.text, 
                apellidoController.text, int.parse(edadController.text));
                setState(() {
                  guardando = false;
                });
            },
             child: Text(guardando? "Espere..." : "Guardar"))
          ],
        ),
    );
  }
}
*/