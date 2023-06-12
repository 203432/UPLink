import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uplink/features/users/domain/entities/user.dart';
import 'package:uplink/features/users/domain/usecase/view_profile.dart';

import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/register_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ViewProfileUseCase viewProfileUseCase;

  UserBloc({required this.viewProfileUseCase}) : super(InitialState()) {
    on<UserEvent>((event, emit) async {
      if (event is GetByUsername){
        try{
          emit(Loading());
          User response = await viewProfileUseCase.execute(event.username);
          emit(Loaded(user: response));
        } catch(e){
          emit(Error(error: e.toString()));
        }
      }
    });
  }
}

class UserAuthentication extends Bloc<UserEvent, UserState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;

  UserAuthentication(
      {required this.loginUseCase, required this.registerUseCase})
      : super(Updating()) {
    on<UserEvent>((event, emit) async {
      if (event is Login) {
        try {
          emit(Updating());
          await loginUseCase.execute(event.username, event.password);
          emit(Updated());
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } else if (event is Register) {
        try {
          emit(Updating());
          print('Esta entrand al bloc');
          await registerUseCase.execute(event.user);
          emit(Updated());
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }
    });
  }
}
