import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theta_edge/models/user.dart';

class ProfileProvider extends ChangeNotifier {
  User _profile = User();

  //constructor
  ProfileProvider() {
    _profile.email = "ahmad dhani@gmail.com";
    _profile.firstName = "Ahmad dhani";
  }

  void updateProfile(User profile) {
    //override our default object
    _profile = profile;
  }

  User get profile => _profile;
}
