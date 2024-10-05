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

  getChatMessages(String chatId) {
    emit(LoadingChatState());
    try {
      FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots();

      emit(ChatSuccessState());
    } catch (error) {
      emit(ChatErrorState());
    }
  }

  Future<void> updateOnlineStatus(bool isOnline, String userId) async {
    emit(OnlineStatusLoadingState());
    try {
      await chatRepo.updateOnlineStatus(isOnline, userId);
      emit(OnlineStatusSuccessState());
    } catch (e) {
      emit(OnlineStatusErrorState());
    }
  }

  Future<void> isUserTyping(bool isOnline, String userId) async {
    emit(UserTypingLoadingState());
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      _checkTypingTimer = Timer(const Duration(milliseconds: 600), () async {
        await chatRepo.isUserTyping(isOnline, userId);
      });
      emit(UserTypingSuccessState());
    } catch (e) {
      emit(UserTypingErrorState());
    }
  }

  Future<void> sendMessage(
      {required String userId,
      required String senderId,
      required String text,
      required bool typing,
      required bool isOnline}) async {
    // emit(UserTypingLoadingState());

    chatRepo.sendMessage(userId, {
      'senderId': senderId,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
      'typing': typing,
      'isOnline': isOnline,
    });
  }

  void fetchAllUsers() async {
    emit(GetAllUserLoadingState());
    try {
      final resp = await chatRepo.fetchAllUsers();
      currentUserId = currentUser?.uid;
      emit(GetAllUserSuccessState(resp));
    } catch (error) {
      emit(GetAllUserErrorState(error.toString()));
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
