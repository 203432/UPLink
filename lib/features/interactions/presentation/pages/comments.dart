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
  CommentsPage({required this.idPost});

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('perfil'),
            BlocBuilder<CommentBloc, CommentState>(builder: (context, state) {
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
                      color: Colors.black12,
                      child: ListTile(
                        leading: Text(post.text),
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
            TextField(
              controller: _comment,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    final String? user_id = prefs.getString('id');
                    print(_comment.text);
                    var comment = Comment(
                        id: 0,
                        user: int.parse(user_id!),
                        post: widget.idPost,
                        text: _comment.text);
                    BlocProvider.of<CommentBlocModify>(context)
                        .add(AddComment(comment: comment));
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 3,
                    color: Theme.of(context).primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
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
