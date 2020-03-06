import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theta_edge/main.dart';
import 'package:theta_edge/screens/loading.dart';
import 'package:theta_edge/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //this is loading status
  bool _isBusy = false;
  bool _hasError = false;

  //our email controller
  TextEditingController _emailController = TextEditingController();
  //our password controller
  TextEditingController _passwordController = TextEditingController();

  //scaffold state key
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  //scaffold state key
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        initialData: null,
        future: AuthService().isAuthenticated(),
        builder: (context, snapshot) {
          print(snapshot.data);

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return LoadingScreen();
            case ConnectionState.done:
              if (snapshot.data != null && snapshot.data) {
                return NavigationContainer();
              } else {
                return _isBusy
                    ? LoadingScreen()
                    : Scaffold(
                        key: _scaffoldKey,
                        body: Container(
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              alignment: Alignment.bottomCenter,
                              image: AssetImage("assets/images/wallpaper.png"),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // SizedBox(
                              //   height: 100,
                              // ),

                              Text(
                                "HRM made easy with app.",
                              ),

                              Image.asset(
                                "assets/images/app_logo.png",
                                height: 50,
                                color: Colors.green,
                                alignment: Alignment.center,
                              ),

                              //organize our error messages
                              _hasError
                                  ? Text(
                                      "Wrong username or password",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                      ),
                                    )
                                  : Text(""),

                              SizedBox(
                                height: 20,
                              ),
                              //error message end

                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    prefixIcon: Icon(Icons.email),
                                    filled: true,
                                    fillColor: Colors.grey[150],
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(
                                        10.0,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: TextFormField(
                                  obscureText: true,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    prefixIcon: Icon(Icons.lock),
                                    filled: true,
                                    fillColor: Colors.grey[150],
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(
                                        10.0,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Sign up",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    Text(
                                      "Forgot password",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 55,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                width: double.infinity,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  color: Colors.black,
                                  //function
                                  onPressed: () async {
                                    setState(() {
                                      _isBusy = true;
                                    });
                                    //validation for our login form
                                    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                                      setState(() {
                                        _hasError = true;
                                        _isBusy = false;
                                      });
                                    } else {
                                      setState(() {
                                        _hasError = false;
                                      });

                                      bool loginStatus = await AuthService().loginRequest(
                                        _emailController.text,
                                        _passwordController.text,
                                      );

                                      if (loginStatus) {
                                        Navigator.of(context).pushNamedAndRemoveUntil(
                                          '/dashboard',
                                          (Route<dynamic> route) => false,
                                        );
                                      } else {
                                        //display error
                                        setState(() {
                                          _hasError = true;
                                          _isBusy = false;
                                        });
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
              }
              break;
            default:
              return LoadingScreen();
          }
        });
  }

  void _onLogin() {}
}
