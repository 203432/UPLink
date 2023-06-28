import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uplink/features/posts/presentation/blocs/post_bloc.dart';
import 'package:uplink/features/users/presentation/blocs/user_bloc.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetByUsername(userId: 0));
    BlocProvider.of<PostBloc>(context).add(GetByUserId(userId: 0));
  }

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 192, 192, 192),
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
            Column(
              children: [
                BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                  if (state is LoadingUser) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedUser) {
                    return Container(
                      width: 375.5,
                      height: 460,
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
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 33, bottom: 15),
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: state.user.url_image != 'null'
                                ? NetworkImage(state.user.url_image)
                                : null,
                            backgroundColor: state.user.url_image != 'null'
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                        Text(
                          '${state.user.first_name} ${state.user.last_name}',
                          style: const TextStyle(fontSize: 45),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            '@${state.user.username}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                width: 100,
                                height: 160,
                                child: Column(
                                  children: [
                                    Text(state.user.friends.length.toString(),
                                        style: const TextStyle(fontSize: 40)),
                                    const Icon(
                                      Icons.person_2,
                                      size: 64,
                                      color: Color(0xFF9C5ABF),
                                    ),
                                    const Text('amigos',
                                        style: TextStyle(fontSize: 22)),
                                  ],
                                )),
                            BlocBuilder<PostBloc, PostState>(
                                builder: (context, state) {
                              if (state is Loading) {
                                return const Center();
                              } else if (state is Loaded) {
                                return Container(
                                    width: 140,
                                    height: 160,
                                    child: Column(
                                      children: [
                                        Text(state.posts.length.toString(),
                                            style: TextStyle(fontSize: 40)),
                                        Icon(
                                          Icons.description,
                                          size: 64,
                                          color: Color(0xFF9C5ABF),
                                        ),
                                        Text('Publicaciones',
                                            style: TextStyle(fontSize: 22)),
                                      ],
                                    ));
                              } else if (state is Error) {
                                return Center(
                                  child: Text(state.error,
                                      style:
                                          const TextStyle(color: Colors.red)),
                                );
                              } else {
                                return Container(
                                  child: Text('posts del usuario'),
                                );
                              }
                            }),
                          ],
                        ),
                      ]),
                    );
                  } else if (state is ErrorUser) {
                    return Center(
                      child: Text(state.error,
                          style: const TextStyle(color: Colors.red)),
                    );
                  } else {
                    return Container(
                      child: Text('perfil de usuario'),
                    );
                  }
                }),
              ],
            ),
            Text('perfil'),
            BlocBuilder<PostBloc, PostState>(builder: (context, state) {
              if (state is Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is Loaded) {
                return SingleChildScrollView(
                  child: Column(
                      children: state.posts.map((post) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: ListTile(
                        leading: Text(post.text),
                      ),
                    );
                  }).toList()),
                );
              } else if (state is Error) {
                return Center(
                  child: Text(state.error,
                      style: const TextStyle(color: Colors.red)),
                );
              } else {
                return Container(
                  child: Text('posts del usuario'),
                );
              }
            }),
          ],
        ),
      ),
      extendBody: true,
    );
  }
}
