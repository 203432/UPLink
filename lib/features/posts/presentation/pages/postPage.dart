import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uplink/features/interactions/presentation/blocs/comment_bloc.dart';
import 'package:uplink/features/interactions/presentation/pages/comments.dart';
import 'package:uplink/features/posts/presentation/blocs/post_bloc.dart';
import 'package:uplink/features/users/presentation/pages/profile.dart';

class PostPage extends StatefulWidget {
  final String? token;
  const PostPage(this.token, {super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late PostFriendsBloc _postFriendsBloc;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostFriendsBloc>(context).add(GetFriendsPosts(userId: 1));
    BlocProvider.of<CommentBloc>(context).add(GetComments(postId: 5));
  }

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return blocPosts(context);
  }

  final screens = [
    const NewWidget(),
    ProfilePage(),
    const NewWidget(),
    const NewWidget(),
    const NewWidget(),
  ];
  Scaffold blocPosts(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      extendBody: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: bottomNav(context),
    );
  }

  Container bottomNav(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.5),
          elevation: 0,
          currentIndex: _index,
          onTap: (int index) {
            setState(() {
              _index = index;
            });
            print(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: "Inicio",
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: "Mi perfil",
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.add),
              label: "Agregar",
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: "Buscar",
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: "Ajustes",
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0),
            ),
          ]),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

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
            BlocBuilder<PostFriendsBloc, PostState>(builder: (context, state) {
              if (state is Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is Loaded) {
                return Center(
                  child: Column(
                      children: state.posts.map((post) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Container(
                        width: 375.5,
                        height: 360,
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
                        child: Column(
                          children: [
                            Text(post.text),
                          ],
                        ),
                      ),
                    );
                  }).toList()),
                );
              } else if (state is Error) {
                return Center(
                  // child: Text(state.error, style: const TextStyle(color: Colors.red)),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(color: Color(0xffE0E0E0)),
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 50, left: 20, right: 20),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: const Image(
                              height: 30,
                              image: AssetImage(
                                'images/logo.png',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container(
                  child: const Text("no hay post"),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
