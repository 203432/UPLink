import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uplink/features/users/domain/entities/user.dart';

import '../blocs/user_bloc.dart';
import '../widgets/userWidgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordAgain = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            Image(
              image: Image.asset(
                'images/logo.png',
                scale: 3,
              ).image,
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            width: 380,
            height: 750,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: SizedBox(
              child: Column(
                children: [
                  Image(image: Image.asset('images/unilogo.png').image),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    child: const SizedBox(
                      width: 360,
                      child: Text(
                        'Nombre',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: 360,
                    height: 50,
                    child: TextField(
                      controller: _firstName,
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
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    child: const SizedBox(
                      width: 360,
                      child: Text(
                        'Apellido',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: 360,
                    height: 50,
                    child: TextField(
                      controller: _lastName,
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
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 10),
                    child: const SizedBox(
                      width: 360,
                      child: Text(
                        'Correo',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: 360,
                    height: 50,
                    child: TextField(
                      controller: _mail,
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
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    child: const SizedBox(
                      width: 360,
                      child: Text(
                        'Usuario',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: 360,
                    height: 50,
                    child: TextField(
                      controller: _username,
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
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10),
                    child: const SizedBox(
                      width: 360,
                      child: Text(
                        'Contraseña',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: 360,
                    height: 50,
                    child: TextField(
                      controller: _password,
                      obscureText: true,
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
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    child: const SizedBox(
                      width: 360,
                      child: Text(
                        'Confirmar contraseña',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: 360,
                    height: 50,
                    child: TextField(
                      controller: _passwordAgain,
                      obscureText: true,
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
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: MaterialButton(
                              onPressed: Navigator.of(context).pop,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              color: Theme.of(context).primaryColor,
                              child: const Text(
                                'Regresar',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: MaterialButton(
                              onPressed: () {
                                register(
                                    _firstName.text,
                                    _lastName.text,
                                    _mail.text,
                                    _username.text,
                                    _password.text,
                                    _passwordAgain.text);
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
      backgroundColor: Colors.white,
    );
  }

  void register(String firstName, String lastName, String mail, String username,
      String password, String password2) {
    if (firstName == '' &&
        lastName == '' &&
        mail == '' &&
        username == '' &&
        password == '' &&
        password2 == '') {
      showAlertDialog("registro fallido", "Completa todos los campos", context);
    } else {
      var user = User(
          id_user: 0,
          first_name: firstName,
          last_name: lastName,
          username: username,
          email: mail,
          password: password,
          id_profile: 0,
          url_image: "",
          description: "");
      BlocProvider.of<UserAuthentication>(context).add(Register(user: user));
      showAlertDialog(
          "Registrado con exito", "Por favor, inicia sesion ahora", context);
    }
  }
}
