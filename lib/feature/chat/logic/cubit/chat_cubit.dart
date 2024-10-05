import 'dart:async';

import 'package:chat_app/feature/chat/logic/cubit/chat_state.dart';
import 'package:chat_app/feature/chat/model/repositories/chat_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatRepo) : super(InitialChat());
  late ChatRepo chatRepo;

  /// Get the current user ID from Firebase Auth
  DatabaseReference usersRef = FirebaseDatabase.instance.ref('users');
  final User? currentUser = FirebaseAuth.instance.currentUser;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? currentUserId;
  Timer? _checkTypingTimer;
  List<Map<String, dynamic>> listUserData=[];


  Future<void> updateOnlineStatus(bool isOnline, String userId) async {
     if (!isClosed) {
    emit(OnlineStatusLoadingState());
     }
    try {
      await chatRepo.updateOnlineStatus(isOnline, userId);
       if (!isClosed) {
      emit(OnlineStatusSuccessState());
       }
    } catch (e) {
       if (!isClosed) {
      emit(OnlineStatusErrorState());
       }
    }
  }

  Future<void> isUserTyping(bool isOnline, String userId) async {
     if (!isClosed) {
    emit(UserTypingLoadingState());
     }
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      _checkTypingTimer = Timer(const Duration(milliseconds: 600), () async {
        await chatRepo.isUserTyping(isOnline, userId);
      });
       if (!isClosed) {
      emit(UserTypingSuccessState());
       }
    } catch (e) {
       if (!isClosed) {
      emit(UserTypingErrorState());
       }
    }
  }

  Future<void> sendMessage(
      {required String userId,
      required String senderId,
      required String text,
      required bool typing,
      required bool isOnline}) async {

    chatRepo.sendMessage(userId, {
      'senderId': senderId,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
      'typing': typing,
      'isOnline': isOnline,
    });
  }

  void fetchAllUsers() async {
     if (!isClosed) {
    emit(GetAllUserLoadingState());

     }
    try {
      final resp = await chatRepo.fetchAllUsers();
      listUserData=resp;
      currentUserId = currentUser?.uid;
       if (!isClosed) {
      emit(GetAllUserSuccessState(resp));
       }
    } catch (error) {
       if (!isClosed) {
      emit(GetAllUserErrorState(error.toString()));
       }
    }
  }

  void updateUserStatus(bool isOnline, bool typing) {
    User? user = firebaseAuth.currentUser;

    if (user != null) {
      usersRef.child(user.uid).update({
        'isOnline': isOnline,
        'typing': typing,
      });
    }
  }

  Future<void> _updateOnlineStatus(bool isOnline, String userId) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      await _firestore.collection('chats').doc(userId).update({
        'isOnline': isOnline,
      });
    } catch (error) {
      print('Error updating online status: $error');
    }
  }
}
