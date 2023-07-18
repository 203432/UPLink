import '../repositories/comment_repository.dart';

class LikePostUseCase {
  final CommentRepository commentRepository;

  LikePostUseCase(this.commentRepository);

  Future<void> execute(int postId) async {
    return await commentRepository.likeAPost(postId);
  }
}