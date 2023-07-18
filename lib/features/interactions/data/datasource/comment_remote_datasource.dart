import 'package:shared_preferences/shared_preferences.dart';
import 'package:uplink/features/interactions/domain/entities/comment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../../users/domain/entities/user.dart';
import 'package:uplink/config.dart';

abstract class CommentRemoteDataSource {
  Future<void> commentPost(Comment comment);
  Future<void> likeAPost(int postId);
  Future<List<Comment>> viewComments(int postId);
}

class CommentRemoteDataSourceImp extends CommentRemoteDataSource {
  String ip = serverIP;

  @override
  Future<void> commentPost(Comment comment) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await Future.delayed(const Duration(seconds: 2));
      final String? token = prefs.getString('Token');
      var url = Uri.http(ip, '/api/v1/comments/');
      var headers = {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      };
      var postItem = {
        "user": comment.user,
        "text": comment.text,
        "post": comment.post
      };

      await http.post(url,
          body: convert.jsonEncode(postItem), headers: headers);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteComment(String commentId) {
    // TODO: implement deleteComment
    throw UnimplementedError();
  }

  @override
  Future<List<Comment>> viewComments(int postId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> resultList = [];
      final String? token = prefs.getString('Token');
      final String? user_id = prefs.getString('id');
      print('Entro al metodo de commentarios');
      var headers = {'Authorization': 'Token $token'};
      var url = Uri.http(ip, '/api/v1/comments/by_post/$postId');
      var response = await http.get(url, headers: headers);
      var jsonResponse = convert.jsonDecode(response.body);
      var results = jsonResponse['results'];
      resultList.addAll(List<Map<String, dynamic>>.from(results));
      List<Comment> commentList = resultList.map((result) {
        var userMap = result['user'] as Map<String, dynamic>;
        var userProfileMap = userMap['profile'] as Map<String, dynamic>;

        var user = User(
          first_name: userMap['first_name'],
          last_name: userMap['last_name'],
          url_image: userProfileMap['url_image'],
          username: '',
          password: '',
          description: '',
          email: '',
          friends: [],
          id_profile: 0,
          id_user: 0,
        );

        return Comment(
          id: result['id'],
          user: 1, // Corregir aquí
          post: result['post'],
          text: result['text'],
          first_name: user.first_name,
          last_name: user.last_name,
          url_image: user.url_image,
        );
      }).toList();
      return commentList;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  @override
  Future<void> likeAPost(int postId) async {
    var url = Uri.http(ip, '/api/v1/post/$postId/update-likes/');
    var headers = {
      'Authorization': 'Token e7a1e4408a2d67ce8e74606d09efe956e9d8f3f6',
      'Content-Type': 'application/json',
    };
    await http.put(url, headers: headers).then((value) => print(value.body));
  }
}
