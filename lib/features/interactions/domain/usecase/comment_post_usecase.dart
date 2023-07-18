import 'package:uplink/features/interactions/domain/entities/comment.dart';
import 'package:uplink/features/interactions/domain/repositories/comment_repository.dart';

class CommentPostUseCase {
  final CommentRepository commentRepository;

  CommentPostUseCase(this.commentRepository);

  Future<void> execute(Comment comment) async {
    return await commentRepository.addComment(comment);
  }
}
