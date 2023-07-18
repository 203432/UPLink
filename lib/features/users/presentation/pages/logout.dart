import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uplink/features/friends/presentation/bloc/friend_bloc.dart';
import 'package:uplink/features/posts/presentation/blocs/post_bloc.dart';
import 'package:uplink/features/users/presentation/blocs/user_bloc.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:uplink/features/users/presentation/pages/login.dart';

class LogoutPage extends StatefulWidget {
  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  File? images;
  ImagePicker _imagePicker = ImagePicker();

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
            Container(
                width: 300,
                height: 100,
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
                child: MaterialButton(
                  onPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.remove('Token');
                    await prefs.remove('id');
                    logout();
                  },
                  child: const Text('Cerrar Sesion'),
                )),
          ],
        ),
      ),
    );
  }

  void logout() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginPage()));
  }
}
