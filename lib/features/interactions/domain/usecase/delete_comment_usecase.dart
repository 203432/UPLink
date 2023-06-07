import 'package:uplink/features/interactions/domain/repositories/comment_repository.dart';

class DeleteCommentUseCase {
  final CommentRepository commentRepository;

  DeleteCommentUseCase(this.commentRepository);

  Future<void> execute(String commentId) async {
    return await commentRepository.deleteComment(commentId);
  }
}
