import 'package:chat_app/feature/chat/logic/cubit/chat_cubit.dart';
import 'package:chat_app/feature/chat/model/repositories/chat_repo.dart';
import 'package:chat_app/feature/home_screen/chat_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllUsersScreen extends StatelessWidget {
  const AllUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChatRepo chatRepo = ChatRepo();
    return Scaffold(
        appBar: AppBar(
          title: Text('All Users'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.logout,
                size: 30,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future:chatRepo.fetchAllUsers(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final users = snapshot.data!;
            return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
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
                                  userName: user['username'],
                                  currentUserId:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  otherUserId: user['UID'],
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                });
          },
        ));
  }
}
