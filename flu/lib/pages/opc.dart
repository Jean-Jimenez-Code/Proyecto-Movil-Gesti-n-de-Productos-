import 'package:flu/pages/add.dart';
import 'package:flu/pages/lista.dart';
import 'package:flutter/material.dart';

class opcion extends StatefulWidget {
  const opcion({super.key});

  @override
  State<opcion> createState() => _opcion();
}

class _opcion extends State<opcion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text("opciones"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        ElevatedButton(child: const Text("agregar"),
        onPressed: ()=>{//onPressed, quiere decir que cuando se precione se ejecutara lo siguiente
          Navigator.push(
            context,
            MaterialPageRoute(builder:(context) =>const Add())//le decimos a que ruta queremos que se vaya.con el nombre de class de widget de la otra pág
          )
        }),
        ElevatedButton(child:const Text('ver lista'),
        onPressed:()=>{
          Navigator.push(context, 
          MaterialPageRoute(builder: (context)=>const TodoList())
          )
        }),
      ]) ,
      ),
      
    );
  }
}