abstract class AuthState {}

class InitialAuth extends AuthState {}

/// SignIn States
class LoginLoadingStates extends AuthState {}

class LoginSuccessStates extends AuthState {}

class LoginErrorStates extends AuthState {
  final String? error;
  LoginErrorStates({this.error});
}

/// Register States
class RegisterLoadingStates extends AuthState {}

class RegisterSuccessStates extends AuthState {}

class RegisterErrorStates extends AuthState {
  final String? error;
  RegisterErrorStates({this.error});
}
