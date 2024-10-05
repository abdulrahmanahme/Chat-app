import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/core/app_const.dart';
import 'package:chat_app/feature/chat/logic/cubit/chat_cubit.dart';
import 'package:chat_app/feature/chat/logic/cubit/chat_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.userName,
    required this.image,
    required this.userId,
  });
  final String userName;
  final String image;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: AppColors.defaultColor,
          gradient: LinearGradient(
            end: Alignment.bottomCenter,
            colors: [
              Color(0XFF121212),
              const Color.fromARGB(255, 90, 62, 114),
            ],
            stops: [.01, .5],
          ),
        ),
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc('usersId${userId}')
                    .collection('messages')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var messages = snapshot.data!.docs;

                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    AppConst.svgPath + 'arrow.svg',
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  SvgPicture.asset(
                                    AppConst.svgPath + 'status50.svg',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),

                          SizedBox(
                            height: 50.h,
                            width: 120.w,
                            child: ListView.builder(
                              itemCount: messages.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 5,
                                      backgroundColor: messages[index]
                                              ['isOnline']
                                          ? Colors.green
                                          : null,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    if (messages[messages.length - 1]
                                            ['typing'] ==
                                        true)
                                      const Text(
                                        "Typing...",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                          // const Spacer(),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                userName,
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                'last seen recently',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withOpacity(.5),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          CircleAvatar(
                            radius: 22.r,
                            backgroundImage: NetworkImage(
                              image,
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Center(child: Text('No users found.'));
                  }
                });
          },
        ));
  }

  @override
  Size get preferredSize => Size(double.infinity, 70.h);
}
