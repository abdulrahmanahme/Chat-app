import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/core/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.userName,
    required this.image,
  });
  final String userName;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // const Spacer(),
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    AppConst.svgPath + 'arrow.svg',
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                SvgPicture.asset(
                  AppConst.svgPath + 'status50.svg',
                ),
              ],
            ),
            const Spacer(),

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
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 70.h);
}
