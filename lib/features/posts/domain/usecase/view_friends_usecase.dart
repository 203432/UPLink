import '../entities/post.dart';
import '../repositories/post_repository.dart';

class ViewFriendsUseCase {
  final PostRepository postRepository;

  ViewFriendsUseCase(this.postRepository);

  Future<List<Post>> execute(int userId) async {
    return await postRepository.getPostsFromFriends(userId);
  }
}
