import 'package:flu/pages/opc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {//para iniciar la app
  runApp(const MyApp());//el nombre del widget
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
@override
 Widget build(BuildContext context) {
  return MaterialApp(//el diseño de la pag
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Arvo',
      primarySwatch: Colors.teal
    ),
  home: Scaffold(
  appBar: AppBar(title: const Text('BUBBLES')),
  
  body: const Inicio()));//mostrara el contenido del widget Inicio 
 }
}

class Inicio extends StatefulWidget{
  const Inicio({super.key});

  @override
  State<Inicio>createState()=> _Inicio();//hacemos un llamado a _Inicio que es lo que tendra el contenido
}

class _Inicio extends State<Inicio> {
   final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(//para la posicion del contenido
      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,//que se coloque en el centro
          
          children: [
             Text(
                  "BUBBLES",
                  style: GoogleFonts.arvo(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.teal),
                ),
            
            TextField(
              obscureText: true,
              controller: _passwordController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
              hintText: "Ej: XXXXX",
              labelText: 'Contraseña',              
              ),
            ),
            const SizedBox(
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
          const SizedBox(
                  height: 40,
                ),
          Text(
                  "Bienvenido, a la App de Gestion de Productos de Limpieza",
                  style: GoogleFonts.arvo(
                      fontSize: 30,
                      color: Colors.teal),
                      textAlign: TextAlign.center,
                ),               
          const Image(
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