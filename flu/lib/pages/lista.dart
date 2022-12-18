import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
 const TodoList({super.key});
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
  @override
  
 State<TodoList> createState() => _TodoListState();
}
 
 
class _TodoListState extends State<TodoList> {
  final List<String> entries = <String>[];
 
  Future<Map> getTodoList() async {
  try {
    var response = await Dio().get(('http://127.0.0.1:3000/todo/product'));
    return response.data;
      } catch (e) {
    return <String, Object>{};
    }
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
      itemBuilder: (BuildContext context, int index) {
      return Padding(//padding es para que luego se pueda dejar una cierta distancia entre valores
        padding: const EdgeInsets.all(10.0),
        child:Center(//para que se queden en el centro
          child:
        Text (' ${entries[index]['nombre']}  ${entries[index]['precio']}'), // para que se muestre el nombre y precio
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

