import 'package:flu/pages/add.dart';
import 'package:flu/pages/lista.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      title: const Text("OPCIONES"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Text(
                  "Elija la actividad a preferir",
                  style: GoogleFonts.arvo(
                      fontSize: 30,
                      color: Colors.teal),
                ),
        const SizedBox(
                  height: 35,
                ),
        ElevatedButton(child: const Text("Agregar Producto +"),
        onPressed: ()=>{//onPressed, quiere decir que cuando se precione se ejecutara lo siguiente
          Navigator.push(
            context,
            MaterialPageRoute(builder:(context) =>const Add())//le decimos a que ruta queremos que se vaya.con el nombre de class de widget de la otra pág
          )
        }),
        const SizedBox(
                  height: 35,
                ),
        ElevatedButton(child:const Text('Ver Lista'),
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