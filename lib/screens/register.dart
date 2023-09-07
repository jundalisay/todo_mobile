import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:todomob/screens/login.dart';
import 'package:todomob/screens/home.dart';
import 'package:dio/dio.dart';



class RegisterScreen extends StatefulWidget {

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _showPassword = false;
  
  final dio = Dio();


  Future<void> registerUsers() async {

    try {
      final response = await dio.post('http://192.168.100.145:4000/api/accounts/create',
        data: {
          'account': {
            'email': usernameController?.text,
            'hash_password': passwordController?.text,
            'full_name': usernameController?.text,
            // 'username': usernameController?.text,
            // 'password': passwordController?.text,
            // 'password_confirmation': passwordController?.text,
          },
        },
      );
      // final response = await dio.post('http://192.168.100.145:4000/api/', data: {
      //   'user[username]': usernameController?.text,
      //   'user[password]': passwordController?.text,
      //   'user[password_confirmation]': passwordController?.text
      // });


      if (response.statusCode == 200) {
        final data = response.data;
        // final accessToken = data['token'];
        final id = data['id'];
        print('ID: $id');
        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(accessToken: accessToken)));
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(id: id)));
        // print('Access Token: $accessToken');
        
      } else {
        print('Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  //   Response response;
  //   debugPrint('username is...');
  //   debugPrint(usernameController?.text);    
  //   try {
  //     response = await dio.post('http://192.168.100.145:4000/api/registration', data: {
  //       'user[username]': usernameController?.text,
  //       'user[password]': passwordController?.text,
  //       'user[password_confirmation]': passwordController?.text
  //     });
  //   } on DioException catch (e) {
  //     if (e.response != null) {

  //       final data = response.data;
  //       final accessToken = data['access_token'];
  //       final renewalToken = data['renewal_token'];        
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(accessToken: accessToken)));        
  //     } else {
  //     }
  //   }    
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: size.width * 0.85,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //   SizedBox(height: size.height * 0.08),
                    const Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),

                    SizedBox(height: size.height * 0.03),
                    TextFormField(
                      // validator: (value) => Validator.validateEmail(value ?? ""),
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: "Username",
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    TextFormField(
                      obscureText: _showPassword,
                      // validator: (value) => Validator.validatePassword(value ?? ""),
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          child: Icon(
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.06),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: registerUsers,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.indigo,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15)
                        ),
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute( builder: (context) => const LoginScreen())),
                        child: Text('Login')
                       ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


 