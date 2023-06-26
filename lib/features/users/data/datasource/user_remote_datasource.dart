import 'package:uplink/features/users/domain/entities/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../../domain/entities/user.dart';

abstract class UserRemoteDataSource {
  Future<Authentication> login(String username, String password);
  Future<void> logout(User user);
  Future<void> register(User user);
  Future<void> updateInfo(User user);
  Future<User> viewProfile(int userId);
}

class UserRemoteDataSourceImp extends UserRemoteDataSource {
  String ip = "192.168.7.32:8000";

  @override
  Future<Authentication> login(String username, String password) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      print("Entro exitosamente al metodo login");
      var url = Uri.http(ip, '/api/v1/login/');
      var body = {'username': username, 'password': password};
      var headers = {'Content-Type': 'application/json'};
      var res = await http.post(url,
          body: convert.jsonEncode(body), headers: headers);
      var responseJson = convert.jsonDecode(res.body);
      var authentication = Authentication(
          token: responseJson['token'],
          user_id: responseJson['user_id'].toString());
      await prefs.setString("Token", authentication.token);
      await prefs.setString("id", authentication.user_id);
      return authentication;
    } catch (e) {
      print(e);
      throw Exception('Failed to log in');
    }
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

  Future<User> viewProfile(int userId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('Token');
      final String? user_id = prefs.getString('id');
      print('entrando al metodo viewprofile');
      var headers = {'Authorization': 'Token $token'};
      var url = Uri.http(ip, '/api/v1/profile/id/$user_id');
      var response = await http.get(url, headers: headers);
      var responseBody = response.body;
      var responseJson = convert.jsonDecode(responseBody);
      var profileJson = responseJson['profile'];
      var user = User(
        id_user: responseJson['pk'],
        first_name: responseJson['first_name'],
        last_name: responseJson['last_name'],
        username: responseJson['username'],
        email: responseJson['email'],
        password: '',
        id_profile: profileJson['id'],
        url_image: profileJson['url_image'].toString(),
        description: profileJson['description'].toString(),
      );
      return user;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
