import 'dart:convert';

import 'package:http/http.dart' as http;

class LeaveService {
  Future<dynamic> getLeaves() async {
    http.Response _response = await http.get(
      'https://jsonplaceholder.typicode.com/todos/',
    );
    print(_response.body);
    var _data = jsonDecode(_response.body);
    return _data;
  }

  Future<dynamic> getLeave(dynamic id) async {
    print("request to api using ID ${id}");

    http.Response _response = await http.get(
      "https://jsonplaceholder.typicode.com/todos/${id}",
    );
    print(_response.body);
    var _data = jsonDecode(_response.body);
    return _data;
  }
}
