import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uplink/features/interactions/presentation/blocs/comment_bloc.dart';
import 'package:uplink/features/posts/presentation/blocs/post_bloc.dart';
import 'package:uplink/features/posts/presentation/pages/postear.dart';
import 'package:uplink/features/users/presentation/pages/logout.dart';
import 'package:uplink/features/users/presentation/pages/profile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../../interactions/presentation/pages/comments.dart';
import '../../../users/presentation/pages/users_list.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  VideoPlayerController? _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    // _audioPlayer.dispose();
    super.dispose();
  }

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
    PostearPage(),
    UsersListPage(),
    LogoutPage(),
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
                        constraints: BoxConstraints(minHeight: 200),
                        width: 375.5,
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
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 20),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: post.url_image != 'null'
                                      ? NetworkImage(post.url_image)
                                      : null,
                                  backgroundColor: post.url_image != 'null'
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                                title: Text(
                                  '${post.first_name} ${post.last_name}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle:
                                    Text('Publicado el: ${post.published}'),
                              ),
                            ),
                            Text(post.text),
                            post.location == 'null'
                                ? Container()
                                : ElevatedButton(
                                    onPressed: () {
                                      openMap(post.location);
                                    },
                                    child: const Text('Ver ubicacion')),
                            post.image == 'null'
                                ? Container()
                                : Image(image: NetworkImage(post.image)),
                            post.media == 'null' ? Container() : Container(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 100, bottom: 30),
                              child: Container(
                                  width: 300,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      color: Color(0x40E1A9FF),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.favorite_border),
                                          const SizedBox(
                                              width:
                                                  4.0), // Espacio opcional entre el icono y el texto
                                          Text(post.num_likes.toString()),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          print(post.id);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => CommentsPage(
                                                      idPost: post.id,
                                                      name:
                                                          '${post.first_name} ${post.last_name}')));
                                        },
                                        icon: const Icon(Icons.comment),
                                      )
                                    ],
                                  )),
                            )
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

  Future<void> openMap(String location) async {
    List<String> coordenadasSeparadas = location.split(',');

    String variable1 = coordenadasSeparadas[0];
    String variable2 = coordenadasSeparadas[1];

    print("Variable 1: $variable1");
    print("Variable 2: $variable2");
    String googleURL =
        'https://www.google.com/maps/search/?api=1&query=$variable1,$variable2';
    var uri = Uri.parse(googleURL);
    await canLaunchUrl(uri) ? await launchUrl(uri) : throw 'nopu';
  }
}
