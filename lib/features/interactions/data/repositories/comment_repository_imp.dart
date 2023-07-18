import 'package:uplink/features/interactions/domain/entities/comment.dart';

import '../../domain/repositories/comment_repository.dart';
import '../datasource/comment_remote_datasource.dart';

class CommentRepositoryImp implements CommentRepository {
  final CommentRemoteDataSource commentRemoteDataSource;

  CommentRepositoryImp({required this.commentRemoteDataSource});

  @override
  Future<void> addComment(Comment comment) async {
    return await commentRemoteDataSource.commentPost(comment);
  }


  @override
  Future<List<Comment>> getCommentByPostId(int postId) async {
    return await commentRemoteDataSource.viewComments(postId);
  }

  @override
  Future<void> likeAPost(int postId) async {
    return await commentRemoteDataSource.likeAPost(postId);
  }
}
