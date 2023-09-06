import 'package:flutter/material.dart';
import 'package:todomob/screens/login_screen.dart';
import 'dart:convert';
import 'package:dio/dio.dart';



class HomeScreen extends StatefulWidget {
  final String accessToken;  
  HomeScreen({required this.accessToken, Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  
  final Dio dio = Dio();
  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  

  Future<void> fetchTasks() async {
    try {
      final response = await dio.get('http://192.168.100.145:4000/api/tasks');
      print(widget.accessToken);

      if (response.statusCode == 200) {
        final responseData = response.data;
        setState(() {
          tasks = List<Map<String, dynamic>>.from(responseData['data']);
        });
      } else {
        setState(() {
          Map<String, dynamic> tasks = {};
        });        
        print('Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateTaskPosition(int taskId, int newPosition) async {
    final data = {
      'id': taskId,
      'position': newPosition,
    };
    print(data);
    try {
      final response = await dio.put('http://192.168.100.145:4000/api/$taskId/updatepos', data: data);
      print('response: ${response.data}');
      if (response.statusCode == 200) {
        print('Task position updated successfully.');
      } else {
        print('Error updating task position: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final task = tasks.removeAt(oldIndex);
            tasks.insert(newIndex, task);

            // Update the task's position in the API
            updateTaskPosition(task['id'], newIndex);
          });
        },
        children: tasks.map((task) {
          return ListTile(
            key: Key(task['id'].toString()),
            title: Text(task['content']),
          );
        }).toList(),
      ),
    );
  }
}
