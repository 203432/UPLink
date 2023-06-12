import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uplink/features/users/domain/entities/user.dart';
import 'package:uplink/features/users/presentation/blocs/user_bloc.dart';

import '../../data/datasource/user_remote_datasource.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
              child: Text('boton de login'),
              onPressed: () async {
                String username = 'monkish';
                String password = 'RWcamacho';
                print('Entro al boton');
                BlocProvider.of<UserAuthentication>(context)
                    .add(Login(username: username, password: password));
              },
            ),
            MaterialButton(
              child: Text('boton de register'),
              onPressed: () async {
                var user = User(
                    description: '',
                    email: 'prueba2@gmail.com',
                    first_name: 'prueba',
                    id_profile: 0,
                    id_user: 0,
                    last_name: 'test',
                    password: 'prueba',
                    url_image: '',
                    username: 'prueba2');
                print('Entro al boton');
                BlocProvider.of<UserAuthentication>(context)
                    .add(Register(user: user));
              },
            ),
            MaterialButton(
              child: Text('boton para ver perfil'),
              onPressed: () async {
                var username = 'monkish';
                print('Entro al boton');
                BlocProvider.of<UserBloc>(context)
                    .add(GetByUsername(username: username));
              },
            ),
          ],
        ),
      ),
    );
  }
}
