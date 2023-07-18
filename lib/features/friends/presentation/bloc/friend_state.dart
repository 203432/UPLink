part of 'friend_bloc.dart';



abstract class FriendState{}


class UpdatingFriends extends FriendState {}

class UpdatedFriend extends FriendState {}

class ErrorFriend extends FriendState {
  final String error;

  ErrorFriend({required this.error});
}
