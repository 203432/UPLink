import 'package:uplink/config.dart';
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
  Future<List<User>> getAllUsers();
}

class UserRemoteDataSourceImp extends UserRemoteDataSource {
  String ip = serverIP;

  @override
  Future<List<User>> getAllUsers() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> resultList = [];
      await Future.delayed(const Duration(seconds: 2));
      final String? token = prefs.getString('Token');
      print('Entro al metodo de obtencion de usuarios');
      var headers = {'Authorization': 'Token $token'};
      var url = Uri.http(ip, '/api/v1/profile/');

      var response = await http.get(url, headers: headers);
      var jsonResponse = convert.jsonDecode(response.body);
      var results = jsonResponse as List<dynamic>;
      resultList.addAll(List<Map<String, dynamic>>.from(results));
      List<User> userList = resultList.map((result) {
        var userProfileMap = result['profile'] as Map<String, dynamic>;
        print(userProfileMap);
        var photo;
        if (userProfileMap['url_image'] == null) {
          photo = 'null';
        } else {
          photo = 'http://${ip}${userProfileMap['url_image']}';
        }
        return User(
          first_name: result['first_name'],
          last_name: result['last_name'],
          url_image: photo,
          username: result['username'],
          email: result['email'],
          friends: [],
          id_profile: 0,
          id_user: result['pk'],
          description: '',
          password: '',
        );
      }).toList();

      return userList;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

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
      print(userId);
      final String? token = prefs.getString('Token');
      print('entrando al metodo viewprofile');
      print('Lista de amigos');
      var headers = {'Authorization': 'Token $token'};
      var url = Uri.http(ip, '/api/v1/profile/$userId');
      var response = await http.get(url, headers: headers);
      var responseBody = response.body;
      print(responseBody);
      var responseJson = convert.jsonDecode(responseBody);
      print(
        responseJson['url_image'].toString(),
      );
      var user = User(
        id_user: responseJson['id_user'],
        first_name: responseJson['first_name'],
        last_name: responseJson['last_name'],
        username: responseJson['username'],
        email: responseJson['email'],
        password: '',
        id_profile: responseJson['id_profile'],
        url_image: 'http://${ip}${responseJson['url_image'].toString()}',
        description: responseJson['description'].toString(),
        friends: List<int>.from(
            responseJson['friends'].map((friend) => friend as int)),
      );
      print(user.friends);
      return user;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
