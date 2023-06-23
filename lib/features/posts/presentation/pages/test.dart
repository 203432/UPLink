import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uplink/features/interactions/domain/entities/comment.dart';
import 'package:uplink/features/interactions/presentation/blocs/comment_bloc.dart';
import 'package:uplink/features/posts/domain/entities/post.dart';
import 'package:uplink/features/posts/presentation/blocs/post_bloc.dart';
import 'package:uplink/features/users/domain/entities/user.dart';
import 'package:uplink/features/users/presentation/blocs/user_bloc.dart';

class TestPost extends StatefulWidget {
  const TestPost({super.key});

  @override
  State<TestPost> createState() => _TestPostState();
}

class _TestPostState extends State<TestPost> {
  String? _image;
  ImagePicker _imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba'),
      ),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              child: Text('boton de lista por usuarios'),
              onPressed: () async {
                int userId = 10;
                print('Entro al boton');
                BlocProvider.of<PostBloc>(context)
                    .add(GetByUserId(userId: userId));
              },
            ),
            MaterialButton(
              child: Text('boton para los post de los amigos'),
              onPressed: () async {
                int userId = 10;
                print('Entro al boton');
                BlocProvider.of<PostFriendsBloc>(context)
                    .add(GetFriendsPosts(userId: userId));
              },
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Seleccionar Imagen'),
            ),
            SizedBox(height: 20),
            _image != null
                ? Image.network(
                    _image!,
                    height: 200,
                  )
                : Text('No se ha seleccionado ninguna imagen.'),
            MaterialButton(
              child: Text('boton para crear post'),
              onPressed: () async {
                var post = Post(
                    id: 0,
                    user: 0,
                    text: 'cesar',
                    published: '',
                    media: '',
                    image: '',
                    num_likes: 0);
                print('Entro al boton');
                BlocProvider.of<PostBlocModify>(context)
                    .add(Posting(post: post));
              },
            ),
            MaterialButton(
              child: Text('boton para editar post'),
              onPressed: () async {
                var post = Post(
                    id: 17,
                    user: 0,
                    text: 'cesar 2',
                    published: '',
                    media: '',
                    image: '',
                    num_likes: 0);
                print('Entro al boton');
                BlocProvider.of<PostBlocModify>(context)
                    .add(UpdatePost(post: post));
              },
            ),
            MaterialButton(
              child: Text('boton para eliminar post'),
              onPressed: () async {
                var postId = "17";
                print('Entro al boton');
                BlocProvider.of<PostBlocModify>(context)
                    .add(DeletePost(postId: postId));
              },
            ),
            MaterialButton(
              child: Text('boton para ver comentarios del post num 5'),
              onPressed: () async {
                var postId = 5;
                print('Entro al boton');
                BlocProvider.of<CommentBloc>(context)
                    .add(GetComments(postId: postId));
              },
            ),
            MaterialButton(
              child: Text('boton para dar like'),
              onPressed: () async {
                var postId = 5;
                print('Entro al boton');
                BlocProvider.of<CommentBlocModify>(context)
                    .add(LikePost(postId: postId));
              },
            ),
            MaterialButton(
              child: Text('Comentar'),
              onPressed: () async {
                var comment = Comment(
                    id: 0, user: 0, post: 5, text: "Comentando el quinto post");
                var postId = 5;
                print('Entro al boton');
                BlocProvider.of<CommentBlocModify>(context)
                    .add(AddComment(comment: comment));
              },
            ),
          ],
        ),
      ),
    );
  }

  // void getImage() async {
  // XFile? xFile = await _imagePicker.pickImage(source: ImageSource.gallery);

  // if(xFile != null) {
  //   String url = await uploadFile('images/${xFile.name}', File(xFile.path));
  //   setState(() {
  //     _image = url;
  //   });
  // } else {
  //   print('No se seleccionó ninguna imagen.');
  // }
}
