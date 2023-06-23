import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uplink/features/interactions/domain/entities/comment.dart';
import 'package:uplink/features/posts/presentation/blocs/post_bloc.dart';
import 'package:uplink/features/users/presentation/blocs/user_bloc.dart';

import '../../domain/entities/post.dart';

class PostearPage extends StatefulWidget {
  final int idPost;
  PostearPage({required this.idPost});

  @override
  State<PostearPage> createState() => _PostearPageState();
}

class _PostearPageState extends State<PostearPage> {
  final TextEditingController _comment = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('perfil'),
            TextField(
              controller: _comment,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    var post = Post(
                        id: 0,
                        user: 0,
                        text: _comment.text,
                        published: '',
                        media: '',
                        image: '',
                        num_likes: 0);
                    BlocProvider.of<PostBlocModify>(context)
                        .add(Posting(post: post));
                    // final SharedPreferences prefs =
                    //     await SharedPreferences.getInstance();
                    // final String? user_id = prefs.getString('id');
                    // print(_comment.text);
                    // var comment = Comment(
                    //     id: 0,
                    //     user: int.parse(user_id!),
                    //     post: widget.idPost,
                    //     text: _comment.text);
                    // BlocProvider.of<CommentBlocModify>(context)
                    //     .add(AddComment(comment: comment));
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
