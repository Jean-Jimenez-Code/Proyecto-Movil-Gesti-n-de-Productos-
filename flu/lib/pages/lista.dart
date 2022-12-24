import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';
import 'dart:typed_data';
import 'dart:convert';

class TodoList extends StatefulWidget {
 const TodoList({super.key});
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
  @override
  
 State<TodoList> createState() => _TodoListState();
}
 
 
class _TodoListState extends State<TodoList> {
  final List<String> entries = <String>[];
 
  Future<Map> getTodoList() async {
  try {
    var response = await Dio().get(('http://10.0.2.2:3000 /todo/product'));
    print(response.data);
    
    return response.data;
      } catch (e) {
    return <String, Object>{};
    }
  }

  Future<void> deleteElement(nom) async {
  final dio = Dio();
  final response = await dio.post('http://10.0.2.2:3000 /borrar/product',data:{'nom':nom});
  print(response.data);
  }
 
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text("Lista"),
      ),
      
      body: Center(
        child: FutureBuilder<Map>( //en ves de colocar el future como return igual funciona colocandolo en child
        future: getTodoList(),
      builder: (BuildContext context, AsyncSnapshot<Map> snap) {
       
      if (snap.hasData) {
      var data = snap.data;
      var entries = [];
      print(data);
      if (data != null) {
        entries = data['list'];
      }
      return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      itemBuilder: ( context,  index) {
      String base64=(entries[index]['imagen']);
      final UriData dat = UriData.parse(base64);
      //List<int> imageBytes = base64Decode(entries[index]['imagen']);
      Uint8List im = dat.contentAsBytes();
      String nom = entries[index]['nombre'];
      return Padding(//padding es para que luego se pueda dejar una cierta distancia entre valores
        padding: const EdgeInsets.all(10.0),
        child:Row(//para que se queden en el centro
          children:[
            Container(
              width: 100,
              height: 100,
              child: Image.memory(im, fit: BoxFit.cover),
            ),
            Text (' ${entries[index]['nombre']}  ${entries[index]['cantidad']}  ${entries[index]['precio']}'),
            IconButton(
              icon: Icon(Icons.delete, color:Colors.red),
              onPressed:() async {
              await deleteElement(nom);
              setState(() {
              entries.removeAt(index);
            });
         },),],          
         // para que se muestre el nombre y precio
        )
      );
      });
      } else {
        return Center(child: Text('Errorr'));
       }
    }),
    ),
    );
  }
}

