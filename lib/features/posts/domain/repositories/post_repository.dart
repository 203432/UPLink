import '../entities/post.dart';

abstract class PostRepository {
  Future<void> createPost(Post post);
  Future<Post> findPostByContent(String content);
  Future<void> updatePost(Post post);
  Future<void> deletePost(String postId);
  Future<List<Post>> getPostsByUserId(String userId);
}
