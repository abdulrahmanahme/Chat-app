import 'dart:developer';

import 'package:chat_app/core/routing/app_route.dart';
import 'package:chat_app/core/routing/routing.dart';
import 'package:chat_app/feature/auth/logic/cubit/auth_state.dart';
import 'package:chat_app/feature/auth/model/repositories/auth/auth_repo.dart';
import 'package:chat_app/feature/home_screen/view/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/toast_widget.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepo) : super(InitialAuth());

  late AuthRepo _authRepo;

  /// Call  _authRepo and get [registerNewUser] when new user create an account
  void registerNewUser(
      {required String name,
      required String email,
      required String password,
      required String phone,
      context}) async {
    emit(RegisterLoadingStates());
    try {
      final res = await _authRepo.registerNewUser(
        name: name,
        email: email,
        password: password,
        phone: phone,
      );
      if (res.user != null) {
        AppToast.successBar(message: 'Login successfully');

        // context.pushNamed(
        //   context,
        //   Routes.chatScreen,
        // );
        emit(RegisterSuccessStates());
      } else {
        AppToast.errorBar(message: 'The email not successful');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AppToast.errorBar(message: 'The password provided is too weak.');
      }
      if (e.code == 'email-already-in-use') {
        AppToast.errorBar(
            message: 'The account already exists for that email.');
      }
    } catch (e) {
      log('sssssssss ${e}');
      AppToast.errorBar(message: 'There is an Error $e');
    }
  }

  /// Call  _authRepo and get [registerNewUser] when new user login

  void signIn(
      {required String email, required String password, context}) async {
    emit(LoginLoadingStates());
    try {
      final credential =
          await _authRepo.signIn(email: email, password: password);

      if (credential.user != null) {
       
        AppToast.successBar(message: 'Login successfully');
        emit(LoginSuccessStates());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AppToast.errorBar(message: 'No user found for that email.');
        print('No user found for that email.');
      }
      if (e.message == 'wrong-password') {
        AppToast.errorBar(message: 'Wrong password provided for that user.');
      }
      emit(LoginErrorStates(error: e.message.toString()));
    } catch (e) {
      AppToast.errorBar(message: 'There is an Error $e');
    }
  }
}
