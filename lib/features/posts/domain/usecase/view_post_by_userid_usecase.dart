import 'package:uplink/features/posts/domain/entities/post.dart';
import 'package:uplink/features/posts/domain/repositories/post_repository.dart';

class ViewPostByUserIdUseCase {
  final PostRepository postRepository;

  ViewPostByUserIdUseCase(this.postRepository);

  Future<List<Post>> execute(String userId) async {
    return await postRepository.getPostsByUserId(userId);
  }
}
