import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:todomob/screens/register.dart';
import 'package:todomob/screens/entryform.dart';
import 'package:todomob/screens/editform.dart';


class HomeScreen extends StatefulWidget {

  HomeScreen({required this.id});
  final String id;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Map<String, dynamic>> data = [];
  late String accountId;

  @override
  void initState() {
    super.initState();
    accountId = widget.id;
    fetchData();
  }

  final Dio dio = Dio();


  Future<List<Map<String?, dynamic>>?> fetchData() async {
    try {
      final response = await dio.get('http://192.168.100.145:4000/api/tasks?account_id=$accountId'); // Replace with your API URL
      if (response.statusCode == 200) {
        final List<dynamic> dataList = response.data['data'];
        final result = List<Map<String, dynamic>>.from(dataList);
        setState(() {
          data = result;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
      return [];
    }
  }



  Future<void> updateTaskPosition(int taskId, int newPosition) async {
    final data = {
      'id': taskId,
      'position': newPosition,
    };
    print(data);
    try {
      final response = await dio.put('http://192.168.100.145:4000/api/tasks/$taskId/updatepos', data: data);
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

  Future<void> deleteTask(String taskId) async {
    final data = {
      'id': taskId
    };
    print('--------------------------data: $data');
    try {
      final response = await dio.delete('http://192.168.100.145:4000/api/tasks/$taskId', data: data);
      print('response: ${response.data}');
      if (response.statusCode == 200) {
        print('Task deleted successfully.');
      } else {
        print('Error deleting task: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: ReorderableListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          final task = data[index];
          return ListTile(
            key: Key('$index'), // Provide a unique key for each item
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(task['position'].toString()),
            ),
            title: Text(task['content']), // Display the task content
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                deleteTask(task['id']);
                fetchData();
              },
            ),
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditForm(id: task['id'])));
            },            
          );
        },
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if(newIndex > oldIndex){
              newIndex -=1;
            }
            final task = data[oldIndex];
            final taskId = task['id']; // Assuming 'id' is the key for the task ID
            final newPosition = newIndex;
            updateTaskPosition(taskId, newPosition); // Pass taskId and newPosition to the method=            
            final tmp = data[oldIndex];
            data.removeAt(oldIndex);
            data.insert(newIndex, tmp);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => EntryForm(id: accountId)));
        },
        child: Icon(Icons.add) // You can use any icon you like
      ),
    );
  }
}

