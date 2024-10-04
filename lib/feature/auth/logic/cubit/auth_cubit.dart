import 'package:chat_app/feature/auth/logic/cubit/auth_state.dart';
import 'package:chat_app/feature/auth/model/repositorys/auth/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/toast_widget.dart';

class SubjectCubit extends Cubit<AuthState> {
  SubjectCubit(this._authRepo) : super(InitialAuth());

  late AuthRepo _authRepo;

  /// Call  _authRepo and get [registerNewUser] when new user create an account
  void registerNewUser({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
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
      AppToast.errorBar(message: 'There is an Error $e');
    }
  }


/// Call  _authRepo and get [registerNewUser] when new user login

  void signIn(
      {required String email, required String password, context}) async {
    emit(LoginLoadingStates());
    try {
      final credential = await _authRepo.signIn(email: email, password: password);
      if (credential.user != null) {
        // Navigator.pushNamed(
        //   context,
        //   AppRoutes.mapScreen,
        // );
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
