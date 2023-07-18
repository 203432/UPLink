import 'package:flutter/material.dart';

void showAlertDialog(String title, String content, BuildContext context) {
  showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
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

class UsernameTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;

  const UsernameTextField({required this.controller, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, left: 10),
          child: SizedBox(
            width: 300,
            child: Text(
              text,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 300,
          height: 50,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;

  const PasswordTextField({required this.controller, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, left: 10),
          child: SizedBox(
            width: 300,
            child: Text(
              text,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          width: 300,
          height: 50,
          child: TextField(
            obscureText: true,
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Image(image: Image.asset('images/unilogo.png').image),
    );
  }
}

class AppNameTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'UP',
              style: TextStyle(
                color: Color(0xFF712F94),
                fontSize: 40,
              ),
            ),
            TextSpan(
              text: 'LINK',
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostField extends StatelessWidget {
  const PostField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFE0E0E0),
      ),
      child: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
              ),
              child: Image(
                  image: Image.asset(
                'images/logoposts.png',
              ).image),
            ),
            SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFE0E0E0),
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  width: 350,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE0E0E0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 350,
                        constraints: const BoxConstraints(
                          minHeight: 60,
                          maxHeight: 270,
                        ),
                        margin: const EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFFFFFFF)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 0),
                                height: 50,
                                child: Row(
                                  children: [
                                    Image(
                                        image: Image.asset(
                                      'images/usertest.png',
                                      scale: 2.5,
                                    ).image),
                                    Column(
                                      children: const [
                                        Text(
                                          'Username',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Description",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 0),
                                width: 350,
                                child: const Text(
                                  'LOREM IMPSUM DOLOR SIT AMET',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 0),
                                width: 350,
                                child: Image(
                                  image:
                                      Image.asset('images/posttest.png').image,
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 80, bottom: 0),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(),
                                    color: Color(0xFFE1A9FF)),
                                height: 30,
                                width: 270,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 60),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.favorite_border,
                                          ),
                                          Text(
                                            '10',
                                            style: TextStyle(fontSize: 7),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 50),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.comment_outlined,
                                          ),
                                          Text(
                                            '10',
                                            style: TextStyle(fontSize: 7),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
