import 'package:uplink/features/posts/domain/entities/post.dart';
import 'package:uplink/features/posts/domain/repositories/post_repository.dart';

class CreatePostUseCase {
  final PostRepository postRepository;

  CreatePostUseCase(this.postRepository);

  Future<void> execute(Post post) async {
    return await postRepository.createPost(post);
  }
}
