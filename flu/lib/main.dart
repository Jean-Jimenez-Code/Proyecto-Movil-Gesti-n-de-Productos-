import 'package:flu/pages/opc.dart';
import 'package:flutter/material.dart';

void main() {//para iniciar la app
  runApp(const MyApp());//el nombre del widget
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
@override
 Widget build(BuildContext context) {
  return MaterialApp(//el diseño de la pag
      title: 'Flutter Demo',
      theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  home: Scaffold(
  appBar: AppBar(title: const Text('Bubles')),
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
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
              labelText: 'Contraseña',
              ),
            ),
           ElevatedButton( child: const Text("ingresar"),//el boton , y como se llamara el boton
             onPressed: ()=>{
             if(_passwordController.text =='12345'){
              Navigator.push(
                context,
                MaterialPageRoute(builder:(context) =>const opcion())//le decimos a que ruta queremos que se vaya.con el nombre de class de widget de la otra pág
              )
             }//onPressed, quiere decir que cuando se precione se ejecutara lo siguiente
          }),     
      ]) ,
      ),
    );
  }
}