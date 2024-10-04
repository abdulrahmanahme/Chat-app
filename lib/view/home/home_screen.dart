import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/view/widgets/custom_app_bar.dart';
import 'package:chat_app/view/widgets/submit_chat_widget.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBlackColor,
      appBar: const CustomAppBar(
        userName: 'Sebastian',
        image:
            'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        child: Column(
          children: [
            BubbleNormal(
              text:
                  'bubble normal with tail bubble normal with tail bubble normal with tailbubble normal with tailbubble normal with tailbubble normal with tailbubble normal with tailbubble normal with tailbubble normal with tailbubble normal with tail',
              isSender: false,
              color: AppColors.meMessageBubbleColor,
              tail: true,
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            BubbleNormal(
              text:
                  'bubble normal with taildddddd  bubble normal with tailddddddbubble normal with tailddddddbubble normal with tailddddddbubble normal with tailddddddbubble normal with tailddddddbubble normal with tailddddddbubble normal with tailddddddbubble normal with tailddddddbubble normal with tailddddddbubble normal with tailddddddbubble normal with tailddddddbubble normal with taildddddd',
              isSender: true,
              color: AppColors.senderMessageBubbleColor,
              tail: true,
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: SubmitChatWidget(
        controller: controller,
      ),
    );
  }
}
