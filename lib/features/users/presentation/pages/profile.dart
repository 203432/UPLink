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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 500,
              height: 500,
              color: Color.fromARGB(255, 192, 192, 192),
              child: Column(
                children: [
                  BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                    if (state is LoadingUser) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is LoadedUser) {
                      return Column(children: [
                        Text(state.user.username),
                      ]);
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
                  Row(
                    children: [
                      BlocBuilder<PostBloc, PostState>(
                          builder: (context, state) {
                        if (state is Loading) {
                          return const Center();
                        } else if (state is Loaded) {
                          return Container(
                              width: 100,
                              height: 100,
                              child: Column(
                                children: [
                                  Text('Cantidad de posts'),
                                  Text(state.posts.length.toString()),
                                ],
                              ));
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
                ],
              ),
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
                      color: Colors.black12,
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
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: const Color(0xFF712F94).withOpacity(0.8),
        onTap: (int val) => setState(() => _index = val),
        currentIndex: _index,
        items: [
          FloatingNavbarItem(icon: Icons.home, title: 'Home'),
          FloatingNavbarItem(icon: Icons.person, title: 'Profile'),
          FloatingNavbarItem(icon: Icons.add_circle),
          FloatingNavbarItem(icon: Icons.search, title: 'Search'),
          FloatingNavbarItem(icon: Icons.settings, title: 'Settings'),
        ],
      ),
    );
  }
}
