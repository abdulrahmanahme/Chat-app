import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/core/app_const.dart';
import 'package:chat_app/feature/auth/view/widgets/custom_text_from_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SubmitChatWidget extends StatelessWidget {
  const SubmitChatWidget({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: double.infinity,
      color: Color(0xff3B3B43),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon:
                        SvgPicture.asset(AppConst.svgPath + 'attachment.svg')),
                
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                        AppConst.svgPath + 'icon_microphone.svg')),
              
              ],
            ),
          ),
        ],
      ),
    );
  }
}
