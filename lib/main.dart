import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uplink/features/interactions/presentation/blocs/comment_bloc.dart';
import 'package:uplink/features/posts/presentation/blocs/post_bloc.dart';
import 'package:uplink/features/posts/presentation/pages/postPage.dart';
import 'package:uplink/features/posts/presentation/pages/test.dart';
import 'package:uplink/features/users/presentation/pages/login.dart';
import 'package:uplink/features/users/presentation/pages/profile.dart';
import 'package:uplink/features/users/presentation/pages/register.dart';
import 'package:uplink/onboarding/onboarding.dart';
import 'package:uplink/use_case_config.dart';

import 'features/users/presentation/blocs/user_bloc.dart';

UsecaseConfig usecaseConfig = UsecaseConfig();
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => UserAuthentication(
              loginUseCase: usecaseConfig.loginUseCase!,
              registerUseCase: usecaseConfig.registerUseCase!),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              UserBloc(viewProfileUseCase: usecaseConfig.viewProfileUseCase!),
        ),
        BlocProvider(
            create: (BuildContext context) => PostBloc(
                viewPostByUserIdUseCase:
                    usecaseConfig.viewPostByUserIdUseCase!)),
        BlocProvider(
            create: (BuildContext context) => PostFriendsBloc(
                viewFriendsUseCase: usecaseConfig.viewFriendsUseCase!)),
        BlocProvider(
          create: (BuildContext context) => CommentBloc(
              viewCommentsOnPostUseCase:
                  usecaseConfig.viewCommentsOnPostUseCase!),
        ),
        BlocProvider(
            create: (BuildContext context) => PostBlocModify(
                createPostUseCase: usecaseConfig.createPostUseCase!,
                editPostUseCase: usecaseConfig.editPostUseCase!,
                deletePostUseCase: usecaseConfig.deletePostUseCase!)),
        BlocProvider(
            create: (BuildContext context) => CommentBlocModify(
                commentPostUseCase: usecaseConfig.commentPostUseCase!,
                likePostUseCase: usecaseConfig.likePostUseCase!))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF712F94),
        ),
        home: LoginPage(),
      ),
    );
  }
}
