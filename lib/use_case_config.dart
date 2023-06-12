import 'package:uplink/features/interactions/data/datasource/comment_remote_datasource.dart';
import 'package:uplink/features/interactions/data/repositories/comment_repository_imp.dart';
import 'package:uplink/features/interactions/domain/usecase/comment_post_usecase.dart';
import 'package:uplink/features/interactions/domain/usecase/like_post_usecase.dart';
import 'package:uplink/features/interactions/domain/usecase/view_comments_onpost.dart';
import 'package:uplink/features/posts/data/datasource/post_remote_datasource.dart';
import 'package:uplink/features/posts/data/repositories/post_repository_imp.dart';
import 'package:uplink/features/posts/domain/usecase/create_post_usecase.dart';
import 'package:uplink/features/posts/domain/usecase/delete_post_usecase.dart';
import 'package:uplink/features/posts/domain/usecase/edit_post_usecase.dart';
import 'package:uplink/features/posts/domain/usecase/view_post_by_userid_usecase.dart';
import 'package:uplink/features/users/domain/usecase/register_usecase.dart';
import 'package:uplink/features/users/domain/usecase/view_profile.dart';

import 'features/users/data/datasource/user_remote_datasource.dart';
import 'features/users/data/repositories/user_repository_imp.dart';
import 'features/users/domain/usecase/login_usecase.dart';

class UsecaseConfig {
  //Comments
  ViewCommentsOnPostUseCase? viewCommentsOnPostUseCase;
  CommentRepositoryImp? commentRepositoryImp;
  CommentRemoteDataSourceImp? commentRemoteDataSourceImp;
  LikePostUseCase? likePostUseCase;
  CommentPostUseCase? commentPostUseCase;

  //Posts
  DeletePostUseCase? deletePostUseCase;
  EditPostUseCase? editPostUseCase;
  ViewPostByUserIdUseCase? viewPostByUserIdUseCase;
  CreatePostUseCase? createPostUseCase;
  PostRepositoryImp? postRepositoryImp;
  PostRemoteDataSourceImp? postRemoteDataSourceImp;

  //User
  ViewProfileUseCase? viewProfileUseCase;
  LoginUseCase? loginUseCase;
  RegisterUseCase? registerUseCase;
  UserRepositoryImp? userRepositoryImpl;
  UserRemoteDataSourceImp? userRemoteDataSourceImpl;

  UsecaseConfig() {
    //Comments
    commentRemoteDataSourceImp = CommentRemoteDataSourceImp();
    commentRepositoryImp = CommentRepositoryImp(
        commentRemoteDataSource: commentRemoteDataSourceImp!);
    viewCommentsOnPostUseCase =
        ViewCommentsOnPostUseCase(commentRepositoryImp!);
    likePostUseCase = LikePostUseCase(commentRepositoryImp!);
    commentPostUseCase = CommentPostUseCase(commentRepositoryImp!);

    //Post
    postRemoteDataSourceImp = PostRemoteDataSourceImp();
    postRepositoryImp =
        PostRepositoryImp(postRemoteDataSource: postRemoteDataSourceImp!);
    viewPostByUserIdUseCase = ViewPostByUserIdUseCase(postRepositoryImp!);
    createPostUseCase = CreatePostUseCase(postRepositoryImp!);
    editPostUseCase = EditPostUseCase(postRepositoryImp!);
    deletePostUseCase = DeletePostUseCase(postRepositoryImp!);

    //User
    userRemoteDataSourceImpl = UserRemoteDataSourceImp();
    userRepositoryImpl =
        UserRepositoryImp(userRemoteDataSource: userRemoteDataSourceImpl!);
    loginUseCase = LoginUseCase(userRepositoryImpl!);
    registerUseCase = RegisterUseCase(userRepositoryImpl!);
    viewProfileUseCase = ViewProfileUseCase(userRepositoryImpl!);
  }
}
