import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var userRef = FirebaseDatabase.instance.ref().child('Users');

  /// Register as a new user by [Email] , [Name] and  [Phone]
  Future<UserCredential> registerNewUser(
      {required String name,
      required String email,
      required String password,
      required String phone,
     }) async {
    var firebaseUserAuth = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    Map userData = {"Name": name, "Email": email, "Phone": phone};
    userRef.child(firebaseUserAuth.user!.uid).set(userData);
    return firebaseUserAuth;
  }

  /// SignIn by email and password
  Future<UserCredential> signIn(
      {required String email, required String password,}) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  }
}
