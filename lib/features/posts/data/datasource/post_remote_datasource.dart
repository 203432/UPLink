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
}

class PostRemoteDataSourceImp extends PostRemoteDataSource {
  String ip = "192.168.191.32:8000";

  @override
  Future<void> createPost(Post post) async {
    var url = Uri.http(ip, '/api/v1/post/');
    var headers = {
      'Authorization': 'Token e7a1e4408a2d67ce8e74606d09efe956e9d8f3f6',
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
  Future<void> deletePost(String postId) async{
    var url = Uri.http(ip, '/api/v1/post/$postId');
    var headers = {
      'Authorization': 'Token e7a1e4408a2d67ce8e74606d09efe956e9d8f3f6',
      'Content-Type': 'application/json',
    };
    var response = await http.delete(url, headers: headers).then((value) => print(value.body));
  }

  @override
  Future<Post> findPostByContent(String content) {
    // TODO: implement findPostByContent
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> getPostsByUserId(int userId) async {
    print('Entro al metodo de getpostbyuserid');
    var headers = {
      'Authorization': 'Token e7a1e4408a2d67ce8e74606d09efe956e9d8f3f6'
    };
    var url = Uri.http(ip, '/api/v1/post/by_user/$userId');
    var response = await http.get(url, headers: headers).then((value) {
      print(value.statusCode);
      print(value.body);
    });

    if (response.statusCode == 200) {
      var returnData = convert
          .jsonDecode(response.body)
          .map<PostModel>((data) => PostModel.fromJson(data))
          .toList();
      return returnData;
    } else {
      throw Exception();
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
}
