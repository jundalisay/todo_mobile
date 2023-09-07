import 'package:flutter/material.dart';
import 'package:todomob/screens/register.dart';
import 'package:todomob/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterScreen(),
      // home: HomeScreen(accessToken: 'asdfasdf'),      
      // home: HomeScreen()
    );
  }
}
