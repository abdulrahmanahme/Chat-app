import 'dart:developer';
import 'package:chat_app/feature/auth/logic/cubit/auth_state.dart';
import 'package:chat_app/feature/auth/model/repositories/auth/auth_repo.dart';
import 'package:chat_app/feature/home_screen/view/all_users_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/toast_widget.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepo) : super(InitialAuth());
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  late AuthRepo _authRepo;

  /// Call  _authRepo and get [registerNewUser] when new user create an account
  void registerNewUser(
      {required String name,
      required String email,
      required String password,
      required String phone,
      context}) async {
    if (!isClosed) {
      emit(RegisterLoadingStates());
    }
    try {
      final res = await _authRepo.registerNewUser(
          name: name, email: email, password: password);
      if (res.user != null) {
        log('ddddddddddddddddd ${res.user}');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => AllUsersScreen(),
          ),
        );

        AppToast.successBar(message: 'Login successfully');
        if (!isClosed) {
          emit(RegisterSuccessStates());
        }
      }
    } on FirebaseAuthException catch (e) {
      AppToast.errorBar(message: e.message);
    } catch (e) {
      log('sssssssss ${e}');
      if (!isClosed) {
        emit(RegisterErrorStates());
      }

      AppToast.errorBar(message: 'There is an Error $e');
    }
  }

  /// Call  _authRepo and get [registerNewUser] when new user login

  void signIn(
      {required String email, required String password, context}) async {
    if (isClosed) {
      emit(LoginLoadingStates());
    }
    try {
      final credential =
          await _authRepo.signIn(email: email, password: password);

      if (credential.user != null) {
       Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => AllUsersScreen(),
          ),
        );
        AppToast.successBar(message: 'Login successfully');
        if (isClosed) {
          emit(LoginSuccessStates());
        }
      }
    } on FirebaseAuthException catch (e) {
      AppToast.errorBar(message: e.message);
      if (isClosed) {
        emit(LoginErrorStates(error: e.message.toString()));
      }
    } catch (e) {
      AppToast.errorBar(message: 'There is an Error $e');
    }
  }
}
