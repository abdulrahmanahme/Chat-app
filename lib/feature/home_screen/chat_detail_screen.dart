// chat_detail_screen.dart

import 'dart:developer';

import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/feature/auth/view/widgets/custom_app_bar.dart';
import 'package:chat_app/feature/auth/view/widgets/submit_chat_widget.dart';
import 'package:chat_app/feature/chat/logic/cubit/chat_cubit.dart';
import 'package:chat_app/feature/chat/logic/cubit/chat_state.dart';
import 'package:chat_app/main.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatDetailScreen extends StatefulWidget {
  final String currentUserId;
  final String otherUserId;
  final String userName;

  ChatDetailScreen(
      {required this.currentUserId,
      required this.otherUserId,
      required this.userName});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen>
    with WidgetsBindingObserver {
  TextEditingController controller = TextEditingController();
  late ChatCubit chatCubit;

  @override
  void initState() {
    chatCubit = BlocProvider.of<ChatCubit>(globleKey.currentContext!);

    WidgetsBinding.instance.addObserver(this);
    chatCubit.updateOnlineStatus(true, widget.currentUserId);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    chatCubit.updateOnlineStatus(false, widget.currentUserId);
    controller.dispose();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      chatCubit.updateOnlineStatus(true, widget.currentUserId);
    } else {
      chatCubit.updateOnlineStatus(false, widget.currentUserId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBlackColor,
      appBar: CustomAppBar(
        userName: widget.userName,
        userId: widget.currentUserId,
        image: '',
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state is GetAllUserLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc('usersId${widget.otherUserId}')
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No messages yet.'));
                }
                var messages = snapshot.data!.docs;

                return ListView.builder(
                  padding: EdgeInsets.only(bottom: 100.h, right: 10.w),
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    if (message['senderId'] == widget.currentUserId) {
                      Align(
                        alignment: Alignment.centerLeft,
                        child: BubbleNormal(
                          text: message['text'],
                          isSender: false,
                          color: AppColors.meMessageBubbleColor,
                          tail: true,
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                    return Align(
                      alignment: Alignment.centerRight,
                      child: BubbleNormal(
                        text: message['text'],
                        isSender: true,
                        color: AppColors.senderMessageBubbleColor,
                        tail: true,
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
          listener: (context, state) {}),
      bottomSheet: SubmitChatWidget(
        controller: controller,
        onPressed: () {
          if (controller.text.isNotEmpty) {
            context.read<ChatCubit>().sendMessage(
                  userId: widget.otherUserId,
                  isOnline: true,
                  senderId: widget.currentUserId,
                  text: controller.text,
                  typing: true,
                );
            controller.clear();
          } else {
            context.read<ChatCubit>().isUserTyping(true, widget.otherUserId);
          }
        },
      ),
    );
  }
}
