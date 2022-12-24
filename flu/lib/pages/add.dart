import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image/image.dart' as img;
import 'package:flutter_image_compress/flutter_image_compress.dart';
//flutter pub get


class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}
File? images;
String? image64;
String?nombreim;

class _AddState extends State<Add> {
  TextEditingController nombre = TextEditingController();
  TextEditingController cantidad = TextEditingController();
  TextEditingController precio = TextEditingController();
      //if (pathIma != null){
     // List<int> pathImage = img.encodeJpg(pathIma, quality:50 );
    //  print(pathImage);
     // final nameImage=(pathImage.toString()).split('/').last.split("'")[0];
    //  final formtoimage = (pathImage.toString()).split('.').last.split("'")[0];
     // final bitimage=pathImage.readAsBytesSync();
    //  final base64=base64Encode(pathImage);
     // String Imagefial="data:image/$formtoimage;base64,$base64";
    //  nombreim = nameImage;
     // image64=Imagefial; 
      //final pathImage = File(picture.path);

    

  

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
          decoration: InputDecoration(labelText: "nombre"),
        ),
        TextField(
          controller:cantidad ,
          decoration: InputDecoration(labelText: "cantidad"),
          ),
        TextField(
          controller:precio ,
          decoration: InputDecoration(labelText: "precio"),
          //keyboardType: TextInputType.number,//para que se ingresen solo numeros
          ),
        ElevatedButton(child: const Text("imagen"),
        onPressed: () async {
              // Carga la imagen desde la galería
              var picture = await ImagePicker().pickImage(source: ImageSource.gallery);

              if (picture == null) {
                // Si no se ha seleccionado ninguna imagen, no hacemos nada
                return;
              }

              // Comprime la imagen
              var compressedImage;
              String format = picture.path.split('.').last;
              if (format == "png") {
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
              final base64 = base64Encode(compressedImage);
              String image64 = "data:image/$format;base64,$base64";
              nombreim =image64;
            
               //if (pathIma != null){
     // List<int> pathImage = img.encodeJpg(pathIma, quality:50 );
    //  print(pathImage);
     // final nameImage=(pathImage.toString()).split('/').last.split("'")[0];
    //  final formtoimage = (pathImage.toString()).split('.').last.split("'")[0];
     // final bitimage=pathImage.readAsBytesSync();
    //  final base64=base64Encode(pathImage);
     // String Imagefial="data:image/$formtoimage;base64,$base64";
    //  nombreim = nameImage;
     // image64=Imagefial; 
      //final pathImage = File(picture.path);

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
            dioConect(nombreim,data);
            print(nombreim);   //para ver si funciona en la consola de depuracion
        } ,
        ),
        images != null
        ? Image.file(
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


void dioConect( image64, data)async {
  Dio dio = Dio();
  

  final response = await dio.post("http://10.0.2.2:3000/todo/product",data:{
    "imagen":image64,
    "nombre":data["nombre"],
    "precio":data["precio"],
    "cantidad":data["cantidad"],
  },).timeout(const Duration(seconds: 50));
  print(response.data);
}
//10.0.2.2:3000  (android)
//127.0.0.1 (pc)
