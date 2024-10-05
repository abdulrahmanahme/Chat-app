import 'package:chat_app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({super.key, required this.controller ,required this.suffix});
  TextEditingController controller = TextEditingController();
  Widget? suffix;
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
          suffix:suffix ,
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
