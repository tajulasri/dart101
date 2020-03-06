//start importing our thirdparty plugins
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String instanceContext = "Auth service";

  String _baseUrl = "http://206.189.85.127/api";

  Future<dynamic> loginRequest(String email, String password) async {
    print("${instanceContext} fire up api call");

    http.Response _response = await http.post(
      "${_baseUrl}/auth/login",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(
        {
          "email": email,
          "password": password,
        },
      ),
    );
    Map<String, dynamic> _data = jsonDecode(_response.body);

    //error checking for authentication message
    if (_data.containsKey('token')) {
      //if user success then setup token
      await setupToken(_data['token'], _data['data']['email']);
      //give ui response
      return true;
    } else {
      //just give value false to our ui
      return false;
    }
  }

  //this method for get profile data from API
  Future<dynamic> getProfile() async {
    String _token = await getToken();

    http.Response _response = await http.get(
      "${_baseUrl}/profile",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: "Bearer ${_token}",
      },
    );
    Map<String, dynamic> _data = jsonDecode(_response.body);
    print(_data);
    return _data;
  }

  //this method for get profile data from API
  Future<dynamic> updateProfile(dynamic data) async {
    String _token = await getToken();

    http.Response _response = await http.put(
      "${_baseUrl}/profile",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: "Bearer ${_token}",
      },
      body: jsonEncode(data),
    );
    Map<String, dynamic> _data = jsonDecode(_response.body);
    print(_data);
    return _data;
  }

  Future<dynamic> setupToken(String token, String email) async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    _sharedPreference.setString('@token', token);
    _sharedPreference.setString('@email', email);
  }

  Future<dynamic> getToken() async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getString('@token');
  }

  Future<bool> isAuthenticated() async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getString('@token') != null ? true : false;
  }

  Future<dynamic> signout() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.clear();
  }
}
