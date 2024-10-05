

import 'package:chat_app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultButton extends StatelessWidget {
  final String buttonText;

  final void Function() function;
  final Color? colors;
  final Color? borderColor;

  final TextStyle? buttonTextStyle;

  const DefaultButton(
      {Key? key,
      required this.buttonText,
      required this.function,
      this.colors,
      this.borderColor,
      this.buttonTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: function,
       
        child: Container(
          width: double.infinity,
          height: 52.h,
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            color: colors ?? AppColors.defaultColor,
            borderRadius: BorderRadius.circular(25),
            border: borderColor != null
                ? Border.all(
                    color: borderColor!,
                  )
                : null,
          ),
          child: Center(
              child: Text(buttonText,
                  style: buttonTextStyle ??
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ))),
        ));
  }
}
