import 'package:shared_preferences/shared_preferences.dart';
import 'package:uplink/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

abstract class FriendRemoteDataSource {
  Future<String> addFriend(int friendId);
}

class FriendRemoteDataSourceImp extends FriendRemoteDataSource {
  String ip = serverIP;

  @override
  Future<String> addFriend(int friendId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('Token');
      final String? user_id = prefs.getString('id');
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      };
      var url = Uri.http(ip, '/api/v1/profile/friend/${user_id}');
      var response = await http.get(url, headers: headers);
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      var friendsList = jsonResponse['friends'] as List<dynamic>;
      bool isFriendFound = false;
      for (var friend in friendsList) {
        print('Friend ID: $friend');
        if (friend == friendId) {
          isFriendFound = true;
        }
        // Realiza alguna acción con cada friendId
      }
      if (isFriendFound) {
        print('este usuario ya es tu amigo');
      } else {
        friendsList.add(friendId);
        var updatedFriendsListJson =
            convert.jsonEncode({'friend_ids': friendsList});

// Realizar la solicitud PUT al servidor
        var response2 = await http.put(
          url,
          headers: headers,
          body: updatedFriendsListJson,
        );
      }
      return 'a';
    } catch (e) {
      throw Exception(e);
    }
  }
}
