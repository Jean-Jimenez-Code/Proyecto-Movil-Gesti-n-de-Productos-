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
  
  bool _showText = false;
  final _formKey = GlobalKey<FormState>();
  bool _buttonEnabled = false;
  final _textFieldControllers = [  TextEditingController(),  TextEditingController(),  TextEditingController(),];
  
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
      title: const Text("AGREGAR"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
        TextField(//como el input , para ingresar datos
          decoration: InputDecoration(labelText: "Nombre"),//el campo que diga nombre
          controller: _textFieldControllers[0],//para que la informacion que coloque el usuario se guarde en este controller
          onChanged: (value) {
            setState(() {
              _buttonEnabled = _textFieldControllers.every((c) => c.text.isNotEmpty);
            });
          },
        ),
        
        TextField(
          controller: _textFieldControllers[1],//para que la informacion que coloque el usuario se guarde en este controller
          onChanged: (value) {
            setState(() {
              _buttonEnabled = _textFieldControllers.every((c) => c.text.isNotEmpty);
            });
          },
          decoration: InputDecoration(labelText: "Cantidad"),
          keyboardType: TextInputType.number,//que solo se muestre el teclado de numeros
          ),
        TextField(
          controller: _textFieldControllers[2],//para que la informacion que coloque el usuario se guarde en este controller
          onChanged: (value) {
            setState(() {
              _buttonEnabled = _textFieldControllers.every((c) => c.text.isNotEmpty);
            });
          },
          decoration: InputDecoration(labelText: "Precio"),
          keyboardType: TextInputType.number,
          //keyboardType: TextInputType.number,//para que se ingresen solo numeros
          ),
        const SizedBox(
                  height: 24,
                ),  
        const Text('Añada una imagen desde la galeria o camara'),
        const SizedBox(
                  height: 14,
                ),  
        ElevatedButton(child: const Text("Camara"),
        onPressed: () async {
              
              // Carga la imagen desde camara
              var picture = await ImagePicker().pickImage(source: ImageSource.camera);//al precionar el boton este ira a la camara para seleccionar una foto
              if (picture == null) {
                // Si no se ha seleccionado ninguna imagen, no hacemos nada
                return;
              }

              // Comprime la imagen
              var compressedImage;
              String format = picture.path.split('.').last;
              if (format == "png") {//si la imagen es formato png se comprimira para transformarla en base64
                compressedImage = await FlutterImageCompress.compressWithFile(//comprimimos la imagen para que la base de datos la acepte
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
        const SizedBox(
                  height: 24,
                ),
        ElevatedButton(child: const Text("Galeria"),
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
                compressedImage = await FlutterImageCompress.compressWithFile(//comprimimos la imagen para que la base de datos la acepte
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
              nombreim = image64;//se guarda la cadena en la variable nombreim
          },
        ),
        const SizedBox(
                  height: 24,
                ),
        ElevatedButton (
          onPressed:_buttonEnabled ? (){  //el boton de enviar            
            var data = { //para usar los datos
            "nombre":_textFieldControllers[0].text,
            "cantidad":_textFieldControllers[1].text,
            "precio":_textFieldControllers[2].text
            
            };
            dioConect(nombreim,data);//los datos guardados en nombreim y data se envian a dioConect para enviarlos a la base de datos
            print(nombreim); 
            setState(() {
            _showText = true;
            });  //para ver si funciona en la consola de depuracion
          }: null,
          child: const Text("Enviar"),
          ),
        const SizedBox(
                  height: 14,
                ),  
        _showText ? const Text('Se ha Enviado Correctamente') : Container(),
        const SizedBox(
                  height: 24,
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


void dioConect( image64, data)async {//recibir image64 y data del boton
  
Dio dio = Dio();

  final response = await dio.post("http://10.0.2.2:3000/todo/product",data:{//en data colocamos los datos que queremos enviar
    "imagen":image64,//guardamos en la variable los datos de la cadena base64
    "nombre":data["nombre"],//guardamos en la variable los datos ingresados en el campo nombre
    "precio":data["precio"],
    "cantidad":data["cantidad"],
  },).timeout(const Duration(seconds: 50));
  print(response.data);
}
//10.0.2.2:3000  (colocar esos datos en la ruta de la base de datos para que funcione en android(Emulador))
//127.0.0.1:3000 (colocar esos datos en la ruta de la base de datos para que funcione en pc)