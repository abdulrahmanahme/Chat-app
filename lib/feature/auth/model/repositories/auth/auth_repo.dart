import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// Register as a new user by [Email] , [Name] and  [Phone]
 registerNewUser({
    required String name,
    required String email,
    required String password,
  }) async {
    var firebaseUserAuth = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = firebaseUserAuth.user;

    // Check if user is successfully created
    if (user != null) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref("users/${user.uid}");
      // Check if the user data exists
      DatabaseEvent event = await userRef.once();
      if (event.snapshot.value == null) {
        // If it doesn't exist, create user data
        await userRef.set({
          'username': name,
          'email': email,
          'createdAt': ServerValue.timestamp,
          'UID': user.uid,
        });
      } else {
        print('User data already exists.');
      }
    }

    return firebaseUserAuth;
  }

  /// SignIn by email and password
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  }
}
