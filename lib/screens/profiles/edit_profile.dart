import 'package:flutter/material.dart';
import 'package:theta_edge/screens/loading.dart';
import 'package:theta_edge/services/auth_service.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  //global state for our form widget
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();

  bool _isBusy = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //point our future to get profile method service
      future: AuthService().getProfile(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return LoadingScreen();
            break;
          case ConnectionState.done:
            if (snapshot.data != null) {
              //map our snapshot data to each respesctive form controller
              _emailController.text = snapshot.data['data']['email'];
              _firstNameController.text = snapshot.data['data']['name'];

              return Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(),
                body: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 8.0,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: "Email address",
                                  labelText: "Email address",
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  contentPadding: EdgeInsets.all(
                                    15.0,
                                  ),
                                  border: InputBorder.none,
                                  // suffixIcon: Icon(
                                  //   Icons.email,
                                  // ),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: _firstNameController,
                                decoration: InputDecoration(
                                  hintText: "First Name",
                                  labelText: "First Name",
                                  // suffixIcon: Icon(
                                  //   Icons.email,
                                  // ),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: _lastNameController,
                                decoration: InputDecoration(
                                  hintText: "Last Name",
                                  labelText: "Last Name",
                                  // suffixIcon: Icon(
                                  //   Icons.email,
                                  // ),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: _mobileController,
                                decoration: InputDecoration(
                                  hintText: "Mobile Number",
                                  labelText: "Mobile Number",
                                  // suffixIcon: Icon(
                                  //   Icons.email,
                                  // ),
                                  prefixIcon: Icon(Icons.phone),
                                  prefixText: "+60 ",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        //width: MediaQuery.of(context).size.width,
                        width: double.infinity,
                        height: 50,
                        margin: EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              7.0,
                            ),
                          ),
                          color: Colors.black,
                          //handle our profile update
                          onPressed: () async {
                            setState(() {
                              _isBusy = true;
                            });
                            var _update = await AuthService().updateProfile(
                              {
                                "email": _emailController.text,
                                "name": _firstNameController.text,
                              },
                            );
                          },
                          child: Text(
                            "Save Profile",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return LoadingScreen();
            }
            break;
          default:
            return LoadingScreen();
        }
      },
    );
  }
}
