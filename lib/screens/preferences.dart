import 'package:flutter/material.dart';
import 'package:theta_edge/services/auth_service.dart';

class PreferencesScreen extends StatefulWidget {
  PreferencesScreen({Key key}) : super(key: key);

  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  //define global key for scaffold
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //provide our scaffold with widget global key
      key: _scaffoldKey,
      appBar: AppBar(
          //elevation: 0,
          ),
      body: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(
                  '/edit_profile',
                );
              },
              leading: Icon(
                Icons.account_circle,
              ),
              title: Text(
                "Edit Profile",
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
              ),
            ),
            ListTile(
              onTap: () async {
                //clear all our shared preferences data
                await AuthService().signout();

                //clear all navigation history and push to login
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login',
                  (Route<dynamic> route) => false,
                );
              },
              leading: Icon(
                Icons.exit_to_app,
              ),
              title: Text(
                "Sign out",
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
              ),
            )
          ],
        ),
      ),
    );
  }
}
