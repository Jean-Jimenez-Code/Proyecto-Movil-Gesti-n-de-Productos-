//Se importan módulos y paquetes  
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';


class TodoList extends StatefulWidget {//Se declara la clase la Clase TodoList
 const TodoList({super.key});
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
  @override
 State<TodoList> createState() => _TodoListState();//Se está devolviendo una instancia de la clase _TodoListState
}
 
 
class _TodoListState extends State<TodoList> {//Clase privada llamada _TodoListState extiende de State y está asociada con un widget TodoList
  final List<String> entries = <String>[];//Declaracion de Lista entries
 
  Future<Map> getTodoList() async {//recibimos los datos del api
  try {
    var response = await Dio().get(('http://10.0.2.2:3000/todo/product'));
    print(response.data);
    
    return response.data;
      } catch (e) {//Si hay Error
    return <String, Object>{};
    }
  }

  Future<void> deleteElement(nom) async {//Enviamos un dato para que cuando el api lo reciba borre los elementos del dato que enviamos
  final dio = Dio();
  final response = await dio.post('http://10.0.2.2:3000/borrar/product',data:{'nom':nom});
  print(response.data);
  }
 
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text("LISTA"),//Titulo en el Appbar
      ),
      
      body: Center(
        child: FutureBuilder<Map>( //en ves de colocar el future como return igual funciona colocandolo en child
        future: getTodoList(),
      builder: (BuildContext context, AsyncSnapshot<Map> snap) {
       
      if (snap.hasData) {//Se ejecutara si la base de datos no es nula
      var data = snap.data;
      var entries = [];

      if (data != null) {
        entries = data['list'];//entries buscara el nombre de la lista del array del api en este caso el que se llame list
      }
      return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,//Pasa por todo el array 
      itemBuilder: ( context,  index) {
      String base64=(entries[index]['imagen']);//Buscara cada cadena de imagen  
      final UriData dat = UriData.parse(base64);//Transformara para mostrarla(imagen)
      Uint8List im = dat.contentAsBytes();//Transformara para mostrarla(imagen)

      String nom = entries[index]['nombre'];//Pasara por cada array y guardara el nombre en la variable nom
      return Padding(//Padding es para que luego se pueda dejar una cierta distancia entre valores
        padding: const EdgeInsets.all(10.0),
        child:Row(//Para que se queden en el centro
          children:[
            Container(
              width: 100,//Las dimensiones de la imagen
              height: 100,
              child: Image.memory(im, fit: BoxFit.cover),
            ),
            Text (' nombre : ${entries[index]['nombre']} \n  cantidad: ${entries[index]['cantidad']} \n  precio: ${entries[index]['precio']} '),//pasara por cada elemento y los mostrara 
            IconButton(
              icon: Icon(Icons.delete, color:Colors.red),//Mostrara un boton para que se puedan eliminar elementos
              onPressed:() async {
              await deleteElement(nom);//Se borrara el elemento guardado en nom dependiendo de la posicion en la que esta el boton a precionar(ya que dependiendo de la posicion existe un valor diferente guardado en nom)
              setState(() {
              entries.removeAt(index);//Quitara el elemento segun la posicion
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

