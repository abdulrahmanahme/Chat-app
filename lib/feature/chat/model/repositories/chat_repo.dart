import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  /// Update the online status of the current user in the 'users' collection
  Future<void> updateOnlineStatus(bool isOnline, String userId) async {
    await _firestore.collection('chats').doc(userId).update({
      'isOnline': isOnline,
    });
  }

  /// Update the Typing status of the current user in the 'users' collection
  Future<void> isUserTyping(bool typing, String userId) async {
    try {
      await _firestore.collection('chats').doc(userId).update({
        'typing': typing,
      });
    } catch (error) {
      print('Error updating online status: $error');
    }
  }

  ///  Send message data to storage
  void sendMessage(String userId, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(userId)
        .collection('messages')
        .add(data);
  }

  /// fetch All Users
  Future<List<Map<String, dynamic>>> fetchAllUsers() async {
    try {
      DatabaseReference usersRef = FirebaseDatabase.instance.ref('users');
      DataSnapshot snapshot = await usersRef.get();

      List<Map<String, dynamic>> users = [];
      String currentUserId =
          _auth.currentUser?.uid ?? ''; // Get current user ID

      if (snapshot.exists) {
        Map<dynamic, dynamic> usersData =
            snapshot.value as Map<dynamic, dynamic>;

        usersData.forEach((key, value) {
          // Ensure that the value is actually a Map before casting
          if (value is Map<dynamic, dynamic>) {
            // Check if the user ID is not the current user's ID
            if (key.toString() != currentUserId) {
              // Convert the map from dynamic keys and values to string keys and dynamic values
              users.add(
                  value.map((key, value) => MapEntry(key.toString(), value)));
            }
          }
        });
      } else {
        print('No users found.');
      }
      return users;
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }
}
