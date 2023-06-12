import 'package:uplink/features/posts/domain/entities/post.dart';

import '../../domain/repositories/post_repository.dart';
import '../datasource/post_remote_datasource.dart';

class PostRepositoryImp implements PostRepository {
  final PostRemoteDataSource postRemoteDataSource;

  PostRepositoryImp({required this.postRemoteDataSource});

  @override
  Future<void> createPost(Post post) async {
    return await postRemoteDataSource.createPost(post);
  }

  @override
  Future<void> deletePost(String postId) async {
    return await postRemoteDataSource.deletePost(postId);
  }

  @override
  Future<Post> findPostByContent(String content) {
    // TODO: implement findPostByContent
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> getPostsByUserId(int userId) async {
    return await postRemoteDataSource.getPostsByUserId(userId);
  }

  @override
  Future<void> updatePost(Post post) async {
    return await postRemoteDataSource.updatePost(post);
  }
}
