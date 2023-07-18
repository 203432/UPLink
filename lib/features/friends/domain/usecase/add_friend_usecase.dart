import 'package:flutter/material.dart';
import 'package:uplink/features/friends/domain/repositories/friend_repository.dart';

class AddFriendUseCase {
  final FriendsRepository friendsRepository;

  AddFriendUseCase(this.friendsRepository);

  Future<String> execute(int friendId) async {
    return await friendsRepository.addFriend(friendId);
  }
}
