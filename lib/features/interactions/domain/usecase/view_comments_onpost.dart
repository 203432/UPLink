import 'package:uplink/features/interactions/domain/entities/comment.dart';
import 'package:uplink/features/interactions/domain/repositories/comment_repository.dart';

class ViewCommentsOnPostUseCase {
  final CommentRepository commentRepository;

  ViewCommentsOnPostUseCase(this.commentRepository);

  Future<List<Comment>> execute(String postId) async {
    return await commentRepository.getCommentByPostId(postId);
  }
}
