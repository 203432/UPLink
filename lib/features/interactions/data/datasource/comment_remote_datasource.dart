import 'package:uplink/features/interactions/domain/entities/comment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../models/comment.dart';

abstract class CommentRemoteDataSource {
  Future<void> commentPost(Comment comment);
  Future<void> likeAPost(int postId);
  Future<List<Comment>> viewComments(int postId);
}

class CommentRemoteDataSourceImp extends CommentRemoteDataSource {
  String ip = "192.168.191.32:8000";

  @override
  Future<void> commentPost(Comment comment) async {
    var url = Uri.http(ip, '/api/v1/comments/');
    var headers = {
      'Authorization': 'Token e7a1e4408a2d67ce8e74606d09efe956e9d8f3f6',
      'Content-Type': 'application/json',
    };
    var postItem = {"user": 1, "text": comment.text, "post": comment.post};

    await http
        .post(url, body: convert.jsonEncode(postItem), headers: headers)
        .then((value) => print(value.body));
  }

  @override
  Future<void> deleteComment(String commentId) {
    // TODO: implement deleteComment
    throw UnimplementedError();
  }

  @override
  Future<List<Comment>> viewComments(int postId) async {
    print('Entro al metodo de commentarios');
    var headers = {
      'Authorization': 'Token e7a1e4408a2d67ce8e74606d09efe956e9d8f3f6'
    };
    var url = Uri.http(ip, '/api/v1/comments/by_post/$postId');
    var response = await http.get(url, headers: headers).then((value) {
      print(value.statusCode);
      print(value.body);
    });

    if (response.statusCode == 200) {
      var returnData = convert
          .jsonDecode(response.body)
          .map<CommentModel>((data) => CommentModel.fromJson(data))
          .toList();
      return returnData;
    } else {
      throw Exception();
    }
  }

  @override
  Future<void> likeAPost(int postId) async {
    print('Entro al metodo put');
    var url = Uri.http(ip, '/api/v1/post/$postId/update-likes/');
    var headers = {
      'Authorization': 'Token e7a1e4408a2d67ce8e74606d09efe956e9d8f3f6',
      'Content-Type': 'application/json',
    };
    var response = await http
        .put(url, headers: headers)
        .then((value) => print(value.body));
  }
}
