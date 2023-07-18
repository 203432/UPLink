import 'package:flutter/material.dart';
import 'package:uplink/features/friends/data/datasource/friend_remote_datasource.dart';
import 'package:uplink/features/friends/domain/repositories/friend_repository.dart';

class FriendsRepositoryImp implements FriendsRepository {
  final FriendRemoteDataSource friendRemoteDataSource;

  FriendsRepositoryImp({required this.friendRemoteDataSource});
  
  @override
  Future<String> addFriend(int friendId) async {
    return await friendRemoteDataSource.addFriend(friendId);
  }
}
