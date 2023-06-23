import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uplink/features/posts/presentation/pages/postPage.dart';
import 'package:uplink/features/users/presentation/blocs/user_bloc.dart';
import 'package:uplink/features/users/presentation/pages/register.dart';

import '../widgets/userWidgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 140),
            width: 330,
            height: 700,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: SizedBox(
              child: Column(
                children: [
                  Logo(),
                  AppNameTitle(),
                  UsernameTextField(
                    controller: _username,
                    text: "usuario",
                  ),
                  UsernameTextField(
                    controller: _password,
                    text: "contraseña",
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: MaterialButton(
                        onPressed: () async {
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          loginMethod(_username.text, _password.text);
                          await Future.delayed(const Duration(seconds: 5)).then(
                              (value) => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => PostPage(prefs.getString('Token')))));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        color: Theme.of(context).primaryColor,
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 180.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: '¿Todavía no tienes una cuenta?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: ' Crear una cuenta',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 178, 56, 234),
                              fontSize: 12,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const RegisterPage()));
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  void loginMethod(String username, String password) async {
    if (username == '' && password == '') {
      showAlertDialog("Acceso denegado", "Completa ambos campos", context);
    } else {
      BlocProvider.of<UserAuthentication>(context)
          .add(Login(username: username, password: password));
    }
  }
}
