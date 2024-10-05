import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/core/app_const.dart';
import 'package:chat_app/feature/auth/view/widgets/custom_text_from_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SubmitChatWidget extends StatefulWidget {
  const SubmitChatWidget({super.key, required this.controller, this.onPressed});
  final TextEditingController controller;
  final void Function()? onPressed;

  @override
  State<SubmitChatWidget> createState() => _SubmitChatWidgetState();
}

class _SubmitChatWidgetState extends State<SubmitChatWidget> {
  bool _isTextEmpty = true;
  @override
  void initState() {
    super.initState();

    // Add listener to check if the text is empty
    widget.controller.addListener(_checkIfTextIsEmpty);
  }

  void _checkIfTextIsEmpty() {
    setState(() {
      _isTextEmpty = widget.controller.text.isEmpty;
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: 80.h,
        width: double.infinity,
        color: Color(0xff3B3B43),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon:
                          SvgPicture.asset(AppConst.svgPath + 'attachment.svg')),
                  Expanded(
                    child: CustomTextFormField(
                      controller: widget.controller,
                      suffix: _isTextEmpty
                          ? SizedBox(
                              child: SvgPicture.asset(
                              AppConst.svgPath + 'icon_sticker.svg',
                              height: 26.h,
                            ))
                          : IconButton(
                              icon: Icon(
                                _isTextEmpty ? Icons.mic : Icons.send,
                                color: Colors.blue,
                              ),
                              onPressed: _isTextEmpty ? null : widget.onPressed,
                            ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                          AppConst.svgPath + 'icon_microphone.svg')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
