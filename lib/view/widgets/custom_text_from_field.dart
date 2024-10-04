import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/core/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({super.key, required this.controller});
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.defaultBlackColor,
          isDense: true,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          hintText: 'Message',
          hintStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textGreyColor,
          ),
          suffix: SizedBox(
            child: SvgPicture.asset(
              AppConst.svgPath + 'icon_sticker.svg',
              height: 26.h,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
