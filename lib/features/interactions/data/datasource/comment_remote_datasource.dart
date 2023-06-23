import 'package:shared_preferences/shared_preferences.dart';
import 'package:uplink/features/interactions/domain/entities/comment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

abstract class CommentRemoteDataSource {
  Future<void> commentPost(Comment comment);
  Future<void> likeAPost(int postId);
  Future<List<Comment>> viewComments(int postId);
}

class CommentRemoteDataSourceImp extends CommentRemoteDataSource {
  String ip = "192.168.241.32:8000";

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
      List<Map<String, dynamic>> resultList = [];
      print('Entro al metodo de commentarios');
      var headers = {
        'Authorization': 'Token e7a1e4408a2d67ce8e74606d09efe956e9d8f3f6'
      };
      var url = Uri.http(ip, '/api/v1/comments/by_post/$postId');
      var response = await http.get(url, headers: headers);
      var jsonResponse = convert.jsonDecode(response.body);
      var results = jsonResponse['results'];
      resultList.addAll(List<Map<String, dynamic>>.from(results));
      List<Comment> commentList = resultList.map((result) {
        return Comment(
          id: result['id'],
          user: result['user'],
          post: result['post'],
          text: result['text'],
        );
      }).toList();
      return commentList;
    } catch (e) {
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
    await http
        .put(url, headers: headers)
        .then((value) => print(value.body));
  }
}
