import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}
File? images;
String? image64;
String? nombreim;

class _AddState extends State<Add> {
  TextEditingController nombre = TextEditingController(); //lo que hace que se pueda guardar lo que se ingrese en nombre
  TextEditingController cantidad = TextEditingController();
  TextEditingController precio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text("agregar"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
        TextField(//como el input , para ingresar datos
          controller: nombre, //para que la informacion que coloque el usuario se guarde en este controller
          decoration: InputDecoration(labelText: "nombre"),//el campo que diga nombre
        ),
        TextField(
          controller:cantidad ,
          decoration: InputDecoration(labelText: "cantidad"),
          keyboardType: TextInputType.number,//que solo se muestre el teclado de numeros
          ),
        TextField(
          controller:precio ,
          decoration: InputDecoration(labelText: "precio"),
          keyboardType: TextInputType.number,
          //keyboardType: TextInputType.number,//para que se ingresen solo numeros
          ),
        ElevatedButton(child: const Text("imagen"),
        onPressed: () async {
              // Carga la imagen desde la galería
              var picture = await ImagePicker().pickImage(source: ImageSource.gallery);//al precionar el boton este ira a la galeria para seleccionar una foto
              if (picture == null) {
                // Si no se ha seleccionado ninguna imagen, no hacemos nada
                return;
              }

              // Comprime la imagen
              var compressedImage;
              String format = picture.path.split('.').last;
              if (format == "png") {//si la imagen es formato png se comprimira para transformarla en base64
                compressedImage = await FlutterImageCompress.compressWithFile(
                  picture.path,
                  minWidth: 200,
                  minHeight: 200,
                );
              } else if (format == "jpg" || format == "jpeg") {
                compressedImage = await FlutterImageCompress.compressWithList(
                  File.fromUri(Uri.file(picture.path)).readAsBytesSync(),
                  minWidth: 200,
                  minHeight: 200,
                );
              }
              // Codifica la imagen comprimida en base64
              final base64 = base64Encode(compressedImage);//se transforma la imagen ya comprimida a base64
              String image64 = "data:image/$format;base64,$base64";//se crea la cadena final de base64
              nombreim =image64;//se guarda la cadena en la variable nombreim
          },
        ),
        ElevatedButton(
          child: const Text("enviar"),
            onPressed:(){  //el boton de enviar
              var data = { //para usar los datos
              "nombre":nombre.text,
              "cantidad":cantidad.text,
              "precio":precio.text
            };
            dioConect(nombreim,data);//los datos guardados en nombreim y data se envian a dioConect para enviarlos a la base de datos
            print(nombreim);   //para ver si funciona en la consola de depuracion
        } ,
        ),
        images != null
        ? Image.file(//mostrar la imagen de flutter
          images!,
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        )
        :const FlutterLogo(size: 200)
      ]) ,
      ),
      
    );
  }
  
  
}


void dioConect( image64, data)async {//resivir image64 y data del boton
  
Dio dio = Dio();

  final response = await dio.post("http://10.0.2.2:3000/todo/product",data:{//en data colocamos los datos que queremos enviar
    "imagen":image64,
    "nombre":data["nombre"],
    "precio":data["precio"],
    "cantidad":data["cantidad"],
  },).timeout(const Duration(seconds: 50));
  print(response.data);
}
//10.0.2.2:3000  (android)
//127.0.0.1 (pc)
