import 'package:uplink/features/posts/domain/repositories/post_repository.dart';

class DeletePostUseCase {
  final PostRepository postRepository;

  DeletePostUseCase(this.postRepository);

  Future<void> execute(String postId) async {
    return await postRepository.deletePost(postId);
  }
}
