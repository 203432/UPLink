import 'package:uplink/features/users/domain/entities/authentication.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../../domain/entities/user.dart';

abstract class UserRemoteDataSource {
  Future<Authentication> login(String username, String password);
  Future<void> logout(User user);
  Future<void> register(User user);
  Future<void> updateInfo(User user);
  Future<User> viewProfile(String username);
}

class UserRemoteDataSourceImp extends UserRemoteDataSource {
  String ip = "192.168.191.32:8000";

  Future<Authentication> login(String username, String password) async {
    print("Entro exitosamente al metodo login");
    var url = Uri.http(ip, '/api/v1/login/');
    var body = {'username': username, 'password': password};
    var headers = {'Content-Type': 'application/json'};
    await http
        .post(url, body: convert.jsonEncode(body), headers: headers)
        .then((response) => {print(response.body)});

    // await prefs.setString('token', );
    throw Exception('Failed to log in');
  }

  Future<void> logout(User user) async {}
  Future<void> register(User user) async {
    print("Entro exitosamente al metodo register");
    var url = Uri.http(ip, '/api/v1/register/');
    var body = {
      'first_name': user.first_name,
      'last_name': user.last_name,
      'username': user.username,
      'email': user.email,
      'password': user.password
    };
    var headers = {'Content-Type': 'application/json'};
    var response = await http
        .post(url, body: convert.jsonEncode(body), headers: headers)
        .then((response) => {print(response.body)});
  }

  Future<void> updateInfo(User user) async {}

  Future<User> viewProfile(String username) async {
    print('entrando al metodo viewprofile');
    var headers = {
      'Authorization': 'Token e7a1e4408a2d67ce8e74606d09efe956e9d8f3f6'
    };
    var url = Uri.http(ip, '/api/v1/profile/user/$username');
    var response = await http
        .get(url, headers: headers)
        .then((response) => print(response.body));
    throw Exception('Failed to log in');
  }
}
