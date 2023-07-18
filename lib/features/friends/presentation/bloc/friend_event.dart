part of 'friend_bloc.dart';

abstract class FriendEvent {}

class AddFriend extends FriendEvent {
  final int friendId;

  AddFriend({required this.friendId});
}
