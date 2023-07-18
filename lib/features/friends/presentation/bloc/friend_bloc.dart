import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uplink/features/friends/domain/usecase/add_friend_usecase.dart';

part 'friend_event.dart';
part 'friend_state.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  final AddFriendUseCase addFriendUseCase;

  FriendBloc({required this.addFriendUseCase}) : super(UpdatingFriends()) {
    on<FriendEvent>((event, emit) async {
      if (event is AddFriend) {
        try {
          emit(UpdatingFriends());
          await addFriendUseCase.execute(event.friendId);
          emit(UpdatedFriend());
        } catch (e) {
          emit(ErrorFriend(error: e.toString()));
        }
      }
    });
  }
}
