import 'package:flu/pages/add.dart';
import 'package:flutter/material.dart';


void main() {
 runApp(const MyApp());
}

//diseño de la app
class MyApp extends StatelessWidget {
 const MyApp({super.key});

 @override
 Widget build(BuildContext context){
  return MaterialApp(
    home:Add(), //importamos el add de pages
  );
 }
}