import 'package:uplink/features/posts/domain/repositories/post_repository.dart';

import '../entities/post.dart';

class EditPostUseCase {
  final PostRepository postRepository;

  EditPostUseCase(this.postRepository);

  Future<void> execute(Post post) async {
    return await postRepository.updatePost(post);
  }
}
