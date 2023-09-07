import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:todomob/screens/home.dart';


class EditForm extends StatefulWidget {

  EditForm({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<EditForm> createState() => EditFormState();
}

class EditFormState extends State<EditForm> {
  var _formKey = GlobalKey<FormState>();
  late String accountId;

  TextEditingController contentController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController tokenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    accountId = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    print('id: $widget.id');
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task $accountId'),
        leading: Icon(Icons.keyboard_arrow_left),
      ),
      body: ListView(
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: TextField(
              controller: contentController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Task',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )
              ),
              onChanged: (value) {
              }
            ),
          ),
          // harga barang
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: TextField(
                controller: positionController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Position',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                onChanged: (value) {
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: TextField(
                controller: tokenController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: 'Token',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                onChanged: (value) {
                }),
          ),

          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Row(
              children: <Widget>[

                Expanded(
                  child: ElevatedButton(
                    child: Text('Save', textScaleFactor: 1.5),
                    onPressed: () {
                      setState(() {
                        postHttp();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(id: widget.id)));
                      });                      
                    },
                  ),
                ),
                Container(width: 5.0),
                Expanded(
                  child: ElevatedButton(
                    child: Text('Cancel', textScaleFactor: 1.5),
                    onPressed: () {
                      // Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(id: accountId)));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void postHttp() async {
    print('content: $contentController.text');

    Response response = await Dio().put("https://farm.gigalixirapp.com/api/tasks/$widget.id", data: {       
      "task": {
        "content": contentController?.text,
        "position": positionController?.text,
        "status": tokenController?.text,                
      }
    });
  }  
}

