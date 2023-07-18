import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uplink/features/interactions/domain/entities/comment.dart';
import 'package:uplink/features/posts/presentation/blocs/post_bloc.dart';
import 'package:uplink/features/users/presentation/blocs/user_bloc.dart';

import '../blocs/comment_bloc.dart';

class CommentsPage extends StatefulWidget {
  final int idPost;
  final String name;
  CommentsPage({required this.idPost, required this.name});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final TextEditingController _comment = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CommentBloc>(context)
        .add(GetComments(postId: widget.idPost));
  }

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Publicacion de',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color(0xFF712F94)),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 300,
                      width: 340,
                      color: Colors.white,
                      child: BlocBuilder<CommentBloc, CommentState>(
                          builder: (context, state) {
                        if (state is LoadingComment) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is LoadedComment) {
                          return SingleChildScrollView(
                            child: Column(
                                children: state.comment.map((post) {
                              return Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
                                color: Color.fromARGB(31, 255, 255, 255),
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
                                    '${post.first_name} ${post.last_name} dijo:',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(post.text),
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
                            child: Text('posts del usuario'),
                          );
                        }
                      }),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    width: 320, // Cambia el ancho del TextField aquí
                    height: 45,
                    child: TextField(
                      controller: _comment,
                      decoration: InputDecoration(
                        hintText: 'Comentar esta publicacion',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fillColor: Color(0xFFF8E9FF),
                        filled: true,
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Color(0xFFAC75CA),
                          ),
                          onPressed: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            final String? user_id = prefs.getString('id');
                            print(_comment.text);
                            var comment = Comment(
                                id: 0,
                                user: int.parse(user_id!),
                                post: widget.idPost,
                                text: _comment.text,
                                first_name: '',
                                last_name: '',
                                url_image: '');
                            BlocProvider.of<CommentBlocModify>(context)
                                .add(AddComment(comment: comment));
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      extendBody: true,
    );
  }
}
