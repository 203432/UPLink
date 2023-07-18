import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uplink/features/friends/presentation/bloc/friend_bloc.dart';
import 'package:uplink/features/posts/presentation/blocs/post_bloc.dart';
import 'package:uplink/features/users/presentation/blocs/user_bloc.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class UsersListPage extends StatefulWidget {
  @override
  State<UsersListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UsersListPage> {
  File? images;
  ImagePicker _imagePicker = ImagePicker();
  @override
  void initState() {
    super.initState();
    initializeBlocs();
  }

  void initializeBlocs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user_id = prefs.getString('id');
    print(user_id);
    BlocProvider.of<UserListBloc>(context).add(GetUsers());
  }

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              width: 200,
              child: Image(
                image: Image.asset('images/logoposts.png').image,
                width: 200,
              ),
            ),
            Container(
              width: 360,
              height: 480,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(37.0),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(8.0, 4.0),
                        blurRadius: 20.0,
                        spreadRadius: 0.0)
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: BlocBuilder<UserListBloc, UserState>(
                    builder: (context, state) {
                  if (state is Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedUserList) {
                    return SingleChildScrollView(
                      child: Column(
                          children: state.users.map((user) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 20),
                              child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: user.url_image != 'null'
                                        ? NetworkImage(user.url_image)
                                        : null,
                                    backgroundColor: user.url_image != 'null'
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                  title: Text(
                                    '${user.first_name} ${user.last_name}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text('@${user.username}'),
                                  trailing: IconButton(
                                      onPressed: () {
                                        print('ola');
                                        print(user.id_user);
                                        BlocProvider.of<FriendBloc>(context)
                                            .add(AddFriend(
                                                friendId: user.id_user));
                                      },
                                      icon: const Icon(Icons.add))),
                            ),
                          ],
                        );
                      }).toList()),
                    );
                  } else if (state is ErrorUser) {
                    return Center(
                      child: Text(state.error,
                          style: const TextStyle(color: Colors.red)),
                    );
                  } else {
                    return Container(
                      child: Text('Lista de usuarios'),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
      extendBody: true,
    );
  }

  void getImage() async {
    XFile? picture = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picture == null) {
      return;
    }
    setState(() {
      images = File(picture.path);
    });
    dioConnect(images!);
  }

  void dioConnect(File images) async {
    try {
      print('Entro al dio');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Dio dio = Dio();
      final String? token = prefs.getString('Token');
      final String? user_id = prefs.getString('id');
      var file = await MultipartFile.fromFile(images.path);

      FormData formData = FormData.fromMap({"url_image": file});

      final response =
          await dio.put("http://192.168.0.104:8000/api/v1/profile/${user_id}",
              data: formData,
              options: Options(headers: {
                'Authorization': 'Token $token',
              }));

      print(response.data);
    } catch (e) {
      print(e);
      if (e is DioException) {
        print(e);
      }
    }
  }
}
