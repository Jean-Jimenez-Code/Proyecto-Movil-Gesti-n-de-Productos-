import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';


class TodoList extends StatefulWidget {
 const TodoList({super.key});
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
  @override
 State<TodoList> createState() => _TodoListState();
}
 
 
class _TodoListState extends State<TodoList> {
  final List<String> entries = <String>[];
 
  Future<Map> getTodoList() async {
  try {
    var response = await Dio().get(('http://10.0.2.2:3000/todo/product'));//resivimos los datos del api
    print(response.data);
    
    return response.data;
      } catch (e) {
    return <String, Object>{};
    }
  }

  Future<void> deleteElement(nom) async {
  final dio = Dio();
  final response = await dio.post('http://10.0.2.2:3000/borrar/product',data:{'nom':nom});//enviamos un dato para que cuando el api lo resiva borre los elementos del dato que enviamos
  print(response.data);
  }
 
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text("LISTA"),
      ),
      
      body: Center(
        child: FutureBuilder<Map>( //en ves de colocar el future como return igual funciona colocandolo en child
        future: getTodoList(),
      builder: (BuildContext context, AsyncSnapshot<Map> snap) {
       
      if (snap.hasData) {//se ejecutara esto si la base de datos no es nula
      var data = snap.data;
      var entries = [];

      if (data != null) {
        entries = data['list'];//entries buscara el nombre de la lista del array del api en este caso el que se llame list
      }
      return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,//ira pasando por todo el array 
      itemBuilder: ( context,  index) {
      String base64=(entries[index]['imagen']);//buscara cada cadena de imagen  
      final UriData dat = UriData.parse(base64);//la transformara para mostrarla(imagen)
      Uint8List im = dat.contentAsBytes();//la transformara para mostrarla(imagen)

      String nom = entries[index]['nombre'];//pasara por cada array y guardara el nombre en la variable nom
      return Padding(//padding es para que luego se pueda dejar una cierta distancia entre valores
        padding: const EdgeInsets.all(10.0),
        child:Row(//para que se queden en el centro
          children:[
            Container(
              width: 100,//las dimensiones de la imagen
              height: 100,
              child: Image.memory(im, fit: BoxFit.cover),
            ),
            Text (' nombre : ${entries[index]['nombre']} \n  cantidad: ${entries[index]['cantidad']} \n  precio: ${entries[index]['precio']} '),//pasara por cada elemento y los mostrara 
            IconButton(
              icon: Icon(Icons.delete, color:Colors.red),//mostrara un boton para que se puedan eliminar elementos
              onPressed:() async {
              await deleteElement(nom);//se borrara el elemento guardado en nom dependiendo de la posicion en la que esta el boton a precionar(ya que dependiendo de la posicion existe un valor diferente guardado en nom)
              setState(() {
              entries.removeAt(index);//quitara el elemento segun la posicion
            });
         },),], 
        )
      );
      });
      } else {
        return Center(child: Text('Buscando Elementos'));
       }
    }),
    ),
    );
  }
}

