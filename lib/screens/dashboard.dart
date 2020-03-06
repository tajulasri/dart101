import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theta_edge/screens/loading.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String instanceContext = "Dashboard screen";

  String email;

  //this is our position for geolocator
  Position position;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((onValue) {
      setState(() {
        email = onValue.getString('@email');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print(snapshot.data);

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return LoadingScreen();
          case ConnectionState.done:
            return Container(
                child: Center(
              child: FlatButton(
                onPressed: () {},
                child: Text("biometric"),
              ),
            ));
          default:
            return LoadingScreen();
        }
      },
    );
  }
}
