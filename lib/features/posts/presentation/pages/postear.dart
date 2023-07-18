import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uplink/config.dart';
import 'package:uplink/features/posts/presentation/blocs/post_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/post.dart';

class PostearPage extends StatefulWidget {
  @override
  State<PostearPage> createState() => _PostearPageState();
}

class _PostearPageState extends State<PostearPage> {
  File? images;
  File? PDF;
  ImagePicker _imagePicker = ImagePicker();
  final TextEditingController _comment = TextEditingController();
  String lat2 = '';
  String long2 = '';
  String latlong = '';
  late String lat = '';
  late String long = '';

  @override
  void initState() {
    super.initState();
  }

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              width: 200,
              child: Image(
                image: Image.asset('images/logoposts.png').image,
                width: 200,
              ),
            ),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 340,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Color(0xFFF8E9FF),
                      borderRadius: BorderRadius.circular(37.0),
                    ),
                    child: Column(
                      children: [
                        images != null
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Image.file(
                                  images!,
                                  width: 250,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                width: 250,
                                height: 150,
                              ),
                        lat2 != ''
                            ? Text('ubicacion obtenida $lat')
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: getImage,
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    size: 40,
                                    color: Color(0xFFA770C5),
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.videocam,
                                    size: 42,
                                    color: Color(0xFFA770C5),
                                  )),
                              IconButton(
                                  onPressed: () {
                                    getLocation().then((value) => {
                                          lat = '${value.latitude}',
                                          long = '${value.longitude}'
                                        });

                                    setState(() {
                                      lat2 = lat;
                                      long2 = long;
                                      latlong = '$lat,$long';
                                    });
                                    print('que imprima los dos');
                                    print(lat);
                                    print(long);
                                  },
                                  icon: const Icon(
                                    Icons.add_location,
                                    size: 42,
                                    color: Color(0xFFA770C5),
                                  )),
                              IconButton(
                                  onPressed: getPDF,
                                  icon: const Icon(
                                    Icons.file_upload,
                                    size: 40,
                                    color: Color(0xFFA770C5),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    width: 1.0,
                                    color: Color(
                                        0xFFA770C5)), // Configura el borde superior aquí
                              ),
                            ),
                            child: TextField(
                              controller: _comment,
                              decoration: InputDecoration(
                                hintText: 'Publica algo',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.send,
                                    color: Color(0xFFA770C5),
                                  ),
                                  onPressed: () async {
                                    print(images);
                                    if (images != null) {
                                      dioConnect(images!, _comment.text);
                                    } else if (PDF != null) {
                                      dioConnect2(PDF!, _comment.text);
                                    } else {
                                      String text = 'null';
                                      if (latlong != '') {
                                        print(latlong);
                                        text = latlong;
                                      }
                                      var post = Post(
                                          id: 0,
                                          user: 0,
                                          text: _comment.text,
                                          published: '',
                                          media: '',
                                          image: '',
                                          location: text,
                                          num_likes: 0,
                                          first_name: '',
                                          last_name: '',
                                          url_image: '');
                                      BlocProvider.of<PostBlocModify>(context)
                                          .add(Posting(post: post));
                                    }
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
            ),
          ],
        ),
      ),
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
  }

  void dioConnect(File images, String data) async {
    try {
      print('Entro al dio');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Dio dio = Dio();
      final String? token = prefs.getString('Token');
      final String? user_id = prefs.getString('id');
      var file = await MultipartFile.fromFile(images.path);

      FormData formData =
          FormData.fromMap({"user": 1, "text": data, "image": file});

      final response = await dio.post("http://${serverIP}/api/v1/post/",
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

    void dioConnect2(File images, String data) async {
    try {
      print('Entro al dio');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Dio dio = Dio();
      final String? token = prefs.getString('Token');
      final String? user_id = prefs.getString('id');
      var file = await MultipartFile.fromFile(images.path);

      FormData formData =
          FormData.fromMap({"user": 1, "text": data, "media": file});

      final response = await dio.post("http://${serverIP}/api/v1/post/",
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

  Future<Position> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Nopi');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('nop2');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('error');
    }

    return await Geolocator.getCurrentPosition();
  }

  void getPDF() async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    setState(() {
      PDF = File(filePickerResult!.files.single.path!);
    });
  }
}
