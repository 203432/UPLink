import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uplink/features/interactions/domain/entities/comment.dart';
import 'package:uplink/features/interactions/domain/usecase/comment_post_usecase.dart';
import 'package:uplink/features/interactions/domain/usecase/like_post_usecase.dart';
import 'dart:convert' as convert;

import 'package:uplink/features/interactions/domain/usecase/view_comments_onpost.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ViewCommentsOnPostUseCase viewCommentsOnPostUseCase;

  CommentBloc({required this.viewCommentsOnPostUseCase})
      : super(InitialState()) {
    on<CommentEvent>((event, emit) async {
      if (event is GetComments) {
        try {
          emit(Loading());
          List<Comment> response =
              await viewCommentsOnPostUseCase.execute(event.postId);
          emit(Loaded(comment: response));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }
    });
  }
}

class CommentBlocModify extends Bloc<CommentEvent, CommentState> {
  final CommentPostUseCase commentPostUseCase;
  final LikePostUseCase likePostUseCase;

  CommentBlocModify(
      {required this.likePostUseCase, required this.commentPostUseCase})
      : super(Updating()) {
    on<CommentEvent>((event, emit) async {
      if (event is LikePost) {
        try {
          emit(Updating());
          await likePostUseCase.execute(event.postId);
          emit(Updated());
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } else if (event is AddComment) {
        try {
          emit(Updating());
          await commentPostUseCase.execute(event.comment);
          emit(Updated());
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }
    });
  }
}
