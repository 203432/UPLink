import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uplink/features/interactions/presentation/blocs/comment_bloc.dart';
import 'package:uplink/features/interactions/presentation/pages/comments.dart';
import 'package:uplink/features/posts/presentation/blocs/post_bloc.dart';

class PostPage extends StatefulWidget {
  final String? token;
  PostPage(this.token);

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
    return Scaffold(
      body: BlocBuilder<PostFriendsBloc, PostState>(builder: (context, state) {
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
                  leading: IconButton(
                    icon: Icon(Icons.comment),
                    onPressed: () {
                      print(post.id);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CommentsPage(idPost: post.id,)));
                    },
                  ),
                  title: Text(post.text),
                ),
              );
            }).toList()),
            
          );
        } else if (state is Error) {
          return Center(
            child: Text(state.error, style: const TextStyle(color: Colors.red)),
          );
        } else {
          return Container(
            child: Text(widget.token!),
          );
        }
      }),
      

      // Container(
      //   decoration: const BoxDecoration(
      //     color: Color(0xFFE0E0E0),
      //   ),
      //   child: Center(
      //     child: Column(
      //       children: [
      //         Container(
      //           margin: const EdgeInsets.only(top: 50),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(40),
      //           ),
      //           child: Image(
      //               image: Image.asset(
      //             'images/logoposts.png',
      //           ).image),
      //         ),
      //         SingleChildScrollView(
      //           child: Container(
      //             decoration: const BoxDecoration(
      //               color: Color(0xFFE0E0E0),
      //             ),
      //             child: Container(
      //               margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
      //               width: 350,
      //               decoration: const BoxDecoration(
      //                 color: Color(0xFFE0E0E0),
      //               ),
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 mainAxisSize: MainAxisSize.max,
      //                 children: [
      //                   Container(
      //                     width: 350,
      //                     constraints: const BoxConstraints(
      //                       minHeight: 60,
      //                       maxHeight: 270,
      //                     ),
      //                     margin: const EdgeInsets.only(top: 20),
      //                     decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(20),
      //                         color: const Color(0xFFFFFFFF)),
      //                     child: Container(
      //                       decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(20),
      //                       ),
      //                       margin: const EdgeInsets.all(20),
      //                       child: Column(
      //                         children: [
      //                           Container(
      //                             margin: const EdgeInsets.only(bottom: 0),
      //                             height: 50,
      //                             child: Row(
      //                               children: [
      //                                 Image(
      //                                     image: Image.asset(
      //                                   'images/usertest.png',
      //                                   scale: 2.5,
      //                                 ).image),
      //                                 Column(
      //                                   children: const [
      //                                     Text(
      //                                       'Username',
      //                                       style: TextStyle(
      //                                         fontSize: 12,
      //                                         fontWeight: FontWeight.bold,
      //                                       ),
      //                                     ),
      //                                     Text(
      //                                       "Description",
      //                                       style: TextStyle(fontSize: 10),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                           Container(
      //                             margin: const EdgeInsets.only(bottom: 0),
      //                             width: 350,
      //                             child: const Text(
      //                               'LOREM IMPSUM DOLOR SIT AMET',
      //                               style: TextStyle(fontSize: 10),
      //                             ),
      //                           ),
      //                           Container(
      //                             margin: const EdgeInsets.only(bottom: 0),
      //                             width: 350,
      //                             child: Image(
      //                               image: Image.asset('images/posttest.png')
      //                                   .image,
      //                             ),
      //                           ),
      //                           Container(
      //                             margin: const EdgeInsets.only(
      //                                 left: 80, bottom: 0),
      //                             decoration: const BoxDecoration(
      //                                 borderRadius: BorderRadius.only(),
      //                                 color: Color(0xFFE1A9FF)),
      //                             height: 30,
      //                             width: 270,
      //                             child: Row(
      //                               mainAxisAlignment: MainAxisAlignment.end,
      //                               children: [
      //                                 Container(
      //                                   margin:
      //                                       const EdgeInsets.only(right: 60),
      //                                   child: Row(
      //                                     children: const [
      //                                       Icon(
      //                                         Icons.favorite_border,
      //                                       ),
      //                                       Text(
      //                                         '10',
      //                                         style: TextStyle(fontSize: 7),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 ),
      //                                 Container(
      //                                   margin:
      //                                       const EdgeInsets.only(right: 50),
      //                                   child: Row(
      //                                     children: const [
      //                                       Icon(
      //                                         Icons.comment_outlined,
      //                                       ),
      //                                       Text(
      //                                         '10',
      //                                         style: TextStyle(fontSize: 7),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           )
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
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

void CommentsWindow(String title, String content, BuildContext context) {
  showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            children: [
              BlocBuilder<CommentBloc, CommentState>(builder: (context, state) {
                if (state is LoadingComment) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedComment) {
                  return SingleChildScrollView(
                    child: Column(
                        children: state.comment.map((comment) {
                      return Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(5),
                        color: Colors.black12,
                        child: ListTile(
                          title: Text(comment.text),
                        ),
                      );
                    }).toList()),
                  );
                } else if (state is ErrorComment) {
                  return Center(
                    child: Text(state.error,
                        style: const TextStyle(color: Colors.red)),
                  );
                } else {
                  return Container(
                    child: Text("comentarios ventanta"),
                  );
                }
              }),
              Text(content),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text(
                "CERRAR",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
