import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:todomob/screens/home.dart';
import 'package:dio/dio.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _showPassword = false;


  final dio = Dio();


  Future<void> login() async {

    try {
      final response = await dio.post(
        'http://192.168.100.145:4000/api/accounts/sign_in',
        data: {
          // 'account': {
            'email': usernameController?.text,
            'hash_password': passwordController?.text,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final id = data['id'];
        print('----------------------------------------ID: $id');        
        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(accessToken: accessToken)));
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(id: id)));        
        // print('Access Token: $accessToken');
        // print('Renewal Token: $renewalToken');
      } else {
        print('Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  //   Response response;
  //   debugPrint('-------------------');
  //   debugPrint(usernameController?.text);     
  //   try {
  //     response = await dio.post('http://192.168.100.145:4000/api/login', data: {
  //       'user[username]': usernameController?.text,
  //       'user[password]': passwordController?.text,
  //     });
  //   } on DioException catch (e) {
  //     if (e.response != null) {
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));        
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
          child: Stack(children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: size.width * 0.85,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // SizedBox(height: size.height * 0.08),
                          const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.06),
                          TextFormField(
                            controller: usernameController,
                            // validator: (value) {
                            //   return Validator.validateEmail(value ?? "");
                            // },
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
                            controller: passwordController,
                            // validator: (value) {
                            //   return Validator.validatePassword(value ?? "");
                            // },
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(
                                      () => _showPassword = !_showPassword);
                                },
                                child: Icon(
                                  _showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
                              hintText: "Password",
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: login,
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.indigo,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 15)),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
