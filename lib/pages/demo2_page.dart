import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';
import 'package:nuevo_intento/Models/image_model.dart';
import 'package:nuevo_intento/Services/imagen_services.dart';
class Demo2Page extends StatefulWidget {
  Demo2Page({Key? key}) : super(key: key);

  @override
  _Demo2PageState createState() => _Demo2PageState();
}

class _Demo2PageState extends State<Demo2Page> {
  final imagePicker = ImagePicker();
  late File? imagenCargada = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Imagen del automóvil"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ImagenDesdeCamara();
        },
        label: const Text('Tomar Foto'),
        icon: const Icon(Icons.camera_alt),
        backgroundColor: Colors.blue,
        ),
        body: getBody(),
    );
  }

  Future imagenDesdeGaleria() async{
    final image = await imagePicker.getImage(
      source: ImageSource.gallery, imageQuality: 50);
      setState(() {
        try {
          if (image != null){
            imagenCargada = File(image.path);
          }
        }catch (e) {}
        }
      );
  }

  Future ImagenDesdeCamara() async{
    final image = await imagePicker.getImage(
      source: ImageSource.camera, imageQuality: 50);
      setState(() {
        try {
          if (image != null){
            imagenCargada = File(image.path);
          }
        }catch (e) {}
        });
  
}
    getBody() {
    return Column(children: [
      SizedBox(
        width: 200,
        height: 200,
        child: FittedBox(
          fit: BoxFit.fill,
          child: imagenCargada == null
              ? Image.asset('assets/images/noimage.png')
              : Image.file(imagenCargada!)
        )),
        ElevatedButton(
          onPressed: () async {
            if (imagenCargada!= null){
              final bytes = imagenCargada!.readAsBytesSync();
              String base64Image = base64Encode(bytes);
              ImageModel imagenAEnviar =
              ImageModel(base64Image: base64Image, imagename: "prueba");

              int x = await ImagenServices().subirImagen(imagenAEnviar);
            }
          },
          child: Text("Cargar imagen"))
    ]);
  }
}