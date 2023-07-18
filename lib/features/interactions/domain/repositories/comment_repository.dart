import 'package:uplink/features/interactions/domain/entities/comment.dart';

abstract class CommentRepository {
  Future<void> addComment(Comment comment);
  Future<List<Comment>> getCommentByPostId(int postId);
  Future<void> likeAPost(int postId);
}
