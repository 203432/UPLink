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
