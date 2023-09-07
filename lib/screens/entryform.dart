import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:todomob/screens/home.dart';


class EntryForm extends StatefulWidget {

  EntryForm({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<EntryForm> createState() => EntryFormState();
}

class EntryFormState extends State<EntryForm> {
  var _formKey = GlobalKey<FormState>();
  late String accountId;

  TextEditingController contentController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController accountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    accountId = widget.id;
    accountController.text = accountId;    
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task $accountId'),
        leading: Icon(Icons.keyboard_arrow_left),
      ),
      body: ListView(
        children: <Widget>[

          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
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

          // TextFormField(
          //   controller: accountController,
          //   style: TextStyle(color: Colors.transparent), // Text color is transparent
          //   decoration: InputDecoration(
          //     hintText: 'Hidden Input',
          //     hintStyle: TextStyle(color: Colors.transparent), // Hint text color is transparent
          //   ),
          // ),

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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(id: accountId)));
                      });                      
                    },
                  ),
                ),
                Container(width: 5.0),
                Expanded(
                  child: ElevatedButton(
                    child: Text('Cancel', textScaleFactor: 1.5),
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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

    Response response = await Dio().post("https://farm.gigalixirapp.com/api/tasks", data: {       
      "task": {
        "content": contentController?.text,
        "position": positionController?.text,
        "account_id": accountController?.text
      }
    });
  }  
}




  // void initState() {
  //   super.initState();
  //   // reset questions
  //   q = 0;
  //   // WidgetsBinding.instance!.addPostFrameCallback((_) async {
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {      
  //     await showDialog<String>(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //         title: Text("Take the personality quiz!", style: Theme.of(context).textTheme.headline4),
  //         content: Text("Are you on the correct career path? Find out by filling the form and answering the questions"),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text("OK", style: TextStyle(color: Colors.teal[400])),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       ),
  //     );
  //   });
  // }
