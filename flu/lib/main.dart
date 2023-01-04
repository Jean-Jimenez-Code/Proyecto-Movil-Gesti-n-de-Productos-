/// Proyecto-Movil-Gestion-de-Productos
/// Grupo 1
/// Integrantes: Jean Jimenez - Jaime Gutierrez - Daniel Lara Salas - Sebastian Urrutia
/// Version:1.0.0
/// Github:https://github.com/Jean-Jimenez-Code/Proyecto-Movil-Gestion-de-Productos
/// Aspectos Tecnicos En https://github.com/Jean-Jimenez-Code/Proyecto-Movil-Gestion-de-Productos/blob/main/README.md

//Se importan módulos y paquetes
import 'package:flu/pages/opc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {//Se define la Funcion main
  runApp(const MyApp());//Se llama a la instancia de MyApp
}

class MyApp extends StatelessWidget {//Se declara la clase la Clase Myapp, es subclase de la clase StatelessWidget de Flutter
  const MyApp({super.key});//Se llama al constructor de la clase padre 
  
@override
 Widget build(BuildContext context) {//Se define el método build
  return MaterialApp(//Se devuelve la instancia de MaterialApp, y configuraciones para aplicacion
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Arvo',
      primarySwatch: Colors.teal
    ),
  home: Scaffold(
  appBar: AppBar(title: const Text('BUBBLES')),//Barra de la aplicacion y su Titulo
  
  body: const Inicio()));//Se muestra el contenido del widget Inicio 
 }
}

class Inicio extends StatefulWidget{//Se declara la clase de Inicio
  const Inicio({super.key});

  @override
  State<Inicio>createState()=> _Inicio();//Hacemos un llamado a _Inicio que es lo que tendra el contenido
}

class _Inicio extends State<Inicio> {//Se usa State con el parametro Inicio
   final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {//Se define el método build
    return Scaffold(//Proporcionar un área de contenido 
      body: Center(//Posicion del contenido
      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,//Se coloque en el centro
          
          children: [
             Text(//Muestra texto en la aplicación
                  "BUBBLES",
                  style: GoogleFonts.arvo(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.teal),
                ),
            
            TextField(//Caja de texto en la aplicacion y configuraciones
              obscureText: true,
              controller: _passwordController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
              hintText: "Ej: XXXXX",
              labelText: 'Contraseña',              
              ),
            ),
            const SizedBox(//Separa los elementos
                  height: 40,
                ),
           ElevatedButton( child: const Text("Ingresar"),//el boton , y como se llamara el boton
             onPressed: ()=>{//onPressed, quiere decir que cuando se precione se ejecutara lo siguiente
             if(_passwordController.text =='12345'){//definimos una contraseña
              Navigator.push(
                context,
                MaterialPageRoute(builder:(context) =>const opcion())//le decimos a que ruta queremos que se vaya.con el nombre de class de widget de la otra pág en este caso 'opcion'
              )
             }
          }),
          const SizedBox(//Separa los elementos de manera auxiliar
                  height: 40,
                ),
          Text(//Texto
                  "Bienvenido, a la App de Gestion de Productos de Limpieza",
                  style: GoogleFonts.arvo(
                      fontSize: 30,
                      color: Colors.teal),
                      textAlign: TextAlign.center,
                ),               
          const Image(//Imagen en el inicio
          width: 50,
          height: 50,
          fit: BoxFit.contain,
          image: NetworkImage('https://cdn.pixabay.com/photo/2016/12/10/08/08/alphabet-1896897_960_720.png'),
        )
      ]) ,
      ),
    );
  }
}