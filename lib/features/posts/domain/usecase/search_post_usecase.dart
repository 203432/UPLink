import 'package:uplink/features/posts/domain/entities/post.dart';
import 'package:uplink/features/posts/domain/repositories/post_repository.dart';

class SearchPostUseCase {
  final PostRepository postRepository;

  SearchPostUseCase(this.postRepository);

  Future<Post> execute(String content) async {
    return await postRepository.findPostByContent(content);
  }
}
