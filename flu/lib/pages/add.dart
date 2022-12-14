import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}


class _AddState extends State<Add> {
  TextEditingController nombre = TextEditingController();
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
        ElevatedButton(onPressed: () {}, child: const Text("imagen")),
        ElevatedButton(
          child: const Text("enviar"),
            onPressed:(){  //el boton de enviar
              var data = { //para usar los datos
              "nombre":nombre.text,
              "cantidad":cantidad.text,
              "precio":precio.text
            };
            dioConect(data);
            print(data);   //para ver si funciona en la consola de depuracion
        } ,
        ),
      ]) ,
      ),
      
    );
  }
}

void dioConect(Map<String, String> data)async {
  Dio dio = Dio();

  var response = await dio.post("http://127.0.0.1:3000/todo/product",data:data);
  print(response);
}
