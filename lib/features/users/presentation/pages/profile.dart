import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uplink/features/posts/presentation/blocs/post_bloc.dart';
import 'package:uplink/features/users/presentation/blocs/user_bloc.dart';
import 'package:uplink/config.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../PDFPages.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    BlocProvider.of<UserBloc>(context)
        .add(GetByUsername(userId: int.parse(user_id!)));
    BlocProvider.of<PostBloc>(context)
        .add(GetByUserId(userId: int.parse(user_id)));
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
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundImage:
                                      state.user.url_image != 'null'
                                          ? NetworkImage(state.user.url_image)
                                          : null,
                                  backgroundColor:
                                      state.user.url_image != 'null'
                                          ? Colors.black
                                          : Colors.grey,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 20,
                                  child: GestureDetector(
                                    onTap: getImage

                                    // Acción cuando se presiona el botón de editar
                                    ,
                                    child: const CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Color(0xFFF8E9FF),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
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
                                return SizedBox(
                                    width: 140,
                                    height: 160,
                                    child: Column(
                                      children: [
                                        Text(state.posts.length.toString(),
                                            style:
                                                const TextStyle(fontSize: 40)),
                                        const Icon(
                                          Icons.description,
                                          size: 64,
                                          color: Color(0xFF9C5ABF),
                                        ),
                                        const Text('Publicaciones',
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
            BlocBuilder<PostBloc, PostState>(builder: (context, state) {
              if (state is Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is Loaded) {
                return Column(
                    children: state.posts.map((post) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
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
                              subtitle: Text('Publicado el: ${post.published}'),
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
                          post.media == 'null'
                              ? Container()
                              : ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PdfPage(pdfUrl: post.media),
                          ),
                        );
                                  },
                                  child: const Text('Ver PDF')),
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
                                    const Icon(Icons.comment),
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList());
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
          await dio.put("http://${serverIP}/api/v1/profile/${user_id}",
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
