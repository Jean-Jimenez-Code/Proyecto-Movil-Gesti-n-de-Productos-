//Se importan módulos y paquetes
import 'package:flu/pages/add.dart';
import 'package:flu/pages/lista.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class opcion extends StatefulWidget {//Se declara la clase la Clase opcion
  const opcion({super.key});

  @override
  State<opcion> createState() => _opcion();//Se está devolviendo una instancia de la clase _opcion
}

class _opcion extends State<opcion> {//Clase privada llamada _opcion extiende de State y está asociada con un widget opcion
  @override
  Widget build(BuildContext context) {//Se define el método build
    return Scaffold(
      appBar: AppBar(
      title: const Text("OPCIONES"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Text(//Muestra texto en la aplicación
                  "Elija la actividad a preferir",
                  style: GoogleFonts.arvo(
                      fontSize: 30,
                      color: Colors.teal),
                      textAlign: TextAlign.center,
                ),
        const SizedBox(//Separa los elementos
                  height: 35,
                ),
        ElevatedButton(child: const Text("Agregar Producto +"),//Boton Agregar
        onPressed: ()=>{//onPressed, quiere decir que cuando se precione se ejecutara lo siguiente
          Navigator.push(
            context,
            MaterialPageRoute(builder:(context) =>const Add())//le decimos a que ruta queremos que se vaya.con el nombre de class de widget de la otra pág
          )
        }),
        const SizedBox(
                  height: 35,
                ),
        ElevatedButton(child:const Text('Ver Lista'),//Boton Ver Lista
        onPressed:()=>{
          Navigator.push(context, 
          MaterialPageRoute(builder: (context)=>const TodoList())//Instancia de la clase TodoList
          )
        }),
      ]) ,
      ),
      
    );
  }
}