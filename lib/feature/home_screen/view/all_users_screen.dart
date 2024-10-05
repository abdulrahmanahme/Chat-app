import 'package:chat_app/feature/chat/logic/cubit/chat_cubit.dart';
import 'package:chat_app/feature/chat/logic/cubit/chat_state.dart';
import 'package:chat_app/feature/chat/view/chat_screen_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Users')),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          DatabaseReference usersRef = FirebaseDatabase.instance.ref('users');
          if (state is GetAllUserLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetAllUserSuccessState) {
            return ListView.builder(
              itemCount: state.userDataList.length,
              itemBuilder: (context, index) {
                final user = state.userDataList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey),
                    child: ListTile(
                      
                        title: Text(user['username'] ?? 'No Name'),
                        subtitle: Text(user['email'] ?? 'No Email'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatDetailScreen(
                                userName:user['username'] ,
                                chatId: usersRef.path,
                                currentUserId:
                                    FirebaseAuth.instance.currentUser!.uid,
                                otherUserId: user['uid'].toString(),
                              ),
                            ),
                          );
                        }),
                  ),
                );
              },
            );
          } else if (state is GetAllUserErrorState) {
            return Center(child: Text(state.error));
          }
          return const Center(child: Text('No users found.'));
        },
      ),
    );
  }
}
