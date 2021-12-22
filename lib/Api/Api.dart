import 'dart:convert';
import 'package:hello_mobiles/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  String baseUrl = url + 'api/';

  //Get data method
  Future getData(String endPoint) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    String url = baseUrl + endPoint;
    var response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    return response;
  }

  // post data for invoice
  Future postData(Map data, String endPoint) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    String url = baseUrl + endPoint;
    var response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(data));
    return response;
  }

  //delete data
  Future deleteData(String endPoint) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    String url = baseUrl + endPoint;
    var response = await http.delete(url, headers: {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    return response;
  }

  //Post data method
  Future loginRegister(Map data, String endPoint) async {
    String url = baseUrl + endPoint;
    var response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json'
        },
        body: jsonEncode(data));
    return response;
  }

  //Post logout method
  Future logOut(Map data, String endPoint) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    String url = baseUrl + endPoint;
    var response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(data));
    return response;
  }
}
