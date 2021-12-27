import 'package:flutter/material.dart';
import 'package:nuevo_intento/Services/usuarios_services.dart';

import 'ingresar.dart';
import 'ingreso_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
TextEditingController loginController = TextEditingController();
TextEditingController passController = TextEditingController();

void _showDialog(BuildContext context, String titulo, String texto) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titulo),
        content: Text(texto),
        actions: <Widget>[
           ElevatedButton(
            child: const Text("Aceptar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    final logo = Padding(
      padding: EdgeInsets.all(20),
        child: Hero(
        tag: 'hero',
        child: SizedBox(
          height: 160,
          child: Image.asset('assets/ac-logo.png'),
        )
      ),
    );

    final inputLogin = Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: loginController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Login',
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0)
          )
        ),
      ),
    );

    final inputPassword = Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: passController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0)
          )
        ),
      ),
    );

    final buttonLogin = Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: ButtonTheme(
        height: 56,
        child: ElevatedButton(
          child: Text('Ingresar',
           style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () async{
            String? token = await UsuariosServices()
            .validarUsuario(loginController.text, passController.text);
            if (token == null) {
              _showDialog(context, "Error", "Credenciales no válidas");
            }else{
              _showDialog(context, "Valido!!", "Todo ok." + token);
              //AppGlobal.token = token;
              Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => IngresoPage()));
            }

          },
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              logo,
              inputLogin,
              inputPassword,
              buttonLogin,
            ],
            
          ),
          
        ),
        
      )
    );
  }
}