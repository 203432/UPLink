import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../models/post.dart';

abstract class PostRemoteDataSource {
  Future<void> createPost(Post post);
  Future<Post> findPostByContent(String content);
  Future<void> updatePost(Post post);
  Future<void> deletePost(String postId);
  Future<List<Post>> getPostsByUserId(int userId);
  Future<List<Post>> getPostsFromFriends(int userId);
}

class PostRemoteDataSourceImp extends PostRemoteDataSource {
  String ip = "192.168.208.32:8000";

  @override
  Future<void> createPost(Post post) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    final String? token = prefs.getString('Token');
    final String? user_id = prefs.getString('id');
    var url = Uri.http(ip, '/api/v1/post/');
    var headers = {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    };
    var postItem = {
      "user": 1,
      "text": post.text,
    };

    await http
        .post(url, body: convert.jsonEncode(postItem), headers: headers)
        .then((value) => print(value.body));
  }

  @override
  Future<void> deletePost(String postId) async {
    var url = Uri.http(ip, '/api/v1/post/$postId');
    var headers = {
      'Authorization': 'Token e7a1e4408a2d67ce8e74606d09efe956e9d8f3f6',
      'Content-Type': 'application/json',
    };
    var response = await http
        .delete(url, headers: headers)
        .then((value) => print(value.body));
  }

  @override
  Future<Post> findPostByContent(String content) {
    // TODO: implement findPostByContent
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> getPostsByUserId(int userId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> resultList = [];
      await Future.delayed(const Duration(seconds: 2));
      final String? token = prefs.getString('Token');
      final String? user_id = prefs.getString('id');
      print('Entro al metodo de getpostbyuserid');
      var headers = {'Authorization': 'Token $token'};
      var url = Uri.http(ip, '/api/v1/post/by_user/$user_id');
      var response = await http.get(url, headers: headers);
      var jsonResponse = convert.jsonDecode(response.body);
      var results = jsonResponse['results'];
      print(results.length);
      resultList.addAll(List<Map<String, dynamic>>.from(results));
      List<Post> postList = resultList.map((result) {
        return Post(
          id: result['id'],
          user: result['user'],
          text: result['text'],
          published: result['published'],
          media: result['media'].toString(),
          image: result['image'].toString(),
          num_likes: result['num_likes'],
        );
      }).toList();

      for (var post in postList) {
        print(post.text);
        print(post.id);
      }

      return postList;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  @override
  Future<void> updatePost(Post post) async {
    print('Entro al metodo put');
    var url = Uri.http(ip, '/api/v1/post/${post.id}');
    var body = {
      'text': post.text,
    };
    var headers = {
      'Authorization': 'Token e7a1e4408a2d67ce8e74606d09efe956e9d8f3f6',
      'Content-Type': 'application/json',
    };
    var response = await http
        .put(url, body: convert.jsonEncode(body), headers: headers)
        .then((value) => print(value.body));
  }

  @override
  Future<List<Post>> getPostsFromFriends(int userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    final String? token = prefs.getString('Token');
    final String? user_id = prefs.getString('id');
    try {
      print('Entro al metodo de getpostbyuserid');
      var headers = {'Authorization': 'Token $token'};
      var urlFriendsList = Uri.http(ip, '/api/v1/profile/friend/$user_id');
      var responseFriendList = await http.get(urlFriendsList, headers: headers);
      var responseJson = convert.jsonDecode(responseFriendList.body);
      var friendsList = List<int>.from(responseJson['friends']);
      print("el body es: ");
      print(friendsList);
      List<Map<String, dynamic>> resultList = [];
      for (var friendId in friendsList) {
        print('estos son los post del usuaurio: ' + friendId.toString());
        var url = Uri.http(ip, '/api/v1/post/by_user/$friendId');
        var response = await http.get(url, headers: headers);
        print('Respuesta para el amigo con ID $friendId:');
        var jsonResponse = convert.jsonDecode(response.body);
        var results = jsonResponse['results'];
        print(results.length);
        resultList.addAll(List<Map<String, dynamic>>.from(results));
      }
      print(resultList);
      print(resultList.length);
      List<Post> postList = resultList.map((result) {
        return Post(
          id: result['id'],
          user: result['user'],
          text: result['text'],
          published: result['published'],
          media: result['media'].toString(),
          image: result['image'].toString(),
          num_likes: result['num_likes'],
        );
      }).toList();

      for (var post in postList) {
        print(post.text);
        print(post.id);
      }

      return postList;
    } catch (e) {
      print(e);
      throw Exception();
    }
  }
}
