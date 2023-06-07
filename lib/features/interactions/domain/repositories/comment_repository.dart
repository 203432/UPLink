import 'package:uplink/features/interactions/domain/entities/comment.dart';

abstract class CommentRepository {
  Future<void> addComment(Comment comment);
  Future<void> deleteComment(String commentId);
  Future<List<Comment>> getCommentByPostId(String postId);
}
