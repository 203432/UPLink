import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uplink/features/posts/domain/entities/post.dart';
import 'package:uplink/features/posts/domain/usecase/create_post_usecase.dart';
import 'package:uplink/features/posts/domain/usecase/delete_post_usecase.dart';
import 'package:uplink/features/posts/domain/usecase/edit_post_usecase.dart';
import 'package:uplink/features/posts/domain/usecase/view_post_by_userid_usecase.dart';
import 'package:uplink/features/users/domain/entities/user.dart';
import 'package:uplink/features/users/domain/usecase/view_profile.dart';

import '../../domain/usecase/view_friends_usecase.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final ViewPostByUserIdUseCase viewPostByUserIdUseCase;

  PostBloc({required this.viewPostByUserIdUseCase}) : super(InitialState()) {
    on<PostEvent>((event, emit) async {
      if (event is GetByUserId) {
        try {
          emit(Loading());
          List<Post> response =
              await viewPostByUserIdUseCase.execute(event.userId);
          emit(Loaded(posts: response));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }
    });
  }
}

class PostFriendsBloc extends Bloc<PostEvent, PostState> {
  final ViewFriendsUseCase viewFriendsUseCase;

  PostFriendsBloc({required this.viewFriendsUseCase}) : super(InitialState()) {
    on<PostEvent>((event, emit) async {
      if (event is GetFriendsPosts) {
        try {
          emit(Loading());
          List<Post> response =
              await viewFriendsUseCase.execute(event.userId);
          emit(Loaded(posts: response));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }
    });
  }
}

class PostBlocModify extends Bloc<PostEvent, PostState> {
  final CreatePostUseCase createPostUseCase;
  final EditPostUseCase editPostUseCase;
  final DeletePostUseCase deletePostUseCase;

  PostBlocModify(
      {required this.createPostUseCase,
      required this.editPostUseCase,
      required this.deletePostUseCase})
      : super(Updating()) {
    on<PostEvent>((event, emit) async {
      if (event is Posting) {
        try {
          emit(Updating());
          await createPostUseCase.execute(event.post);
          emit(Updated());
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } else if (event is UpdatePost) {
        try {
          emit(Updating());
          await editPostUseCase.execute(event.post);
          emit(Updated());
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } else if (event is DeletePost) {
        try {
          emit(Updating());
          await deletePostUseCase.execute(event.postId);
          emit(Updated());
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }
    });
  }
}
