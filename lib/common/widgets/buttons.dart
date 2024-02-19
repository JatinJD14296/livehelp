import 'package:flutter/material.dart';
import 'package:livehelp/Utils/screen_utils.dart';
import 'icon_and_images.dart';
import 'text_and_styles.dart';
import 'package:livehelp/Utils/colors.dart';


Widget submitButton({
  required String text,
  required Function() onPressed,
  Color textColor = AppColors.whiteColor,
  double height = 40,
  Color? backgroundColor,
  bool isBorder = false,
  Color bColor = AppColors.blueColor,
  bool buttonLogo = false,
  double radius = 25.0,
  double width = 50,
  Widget? child,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      gradient: backgroundColor == null
          ? const LinearGradient(
              colors:AppColors. gradientColor,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )
          : null,
      color: backgroundColor,
      borderRadius: BorderRadius.circular(radius),
      border: isBorder
          ? Border.all(
              color: bColor,
              style: BorderStyle.solid,
            )
          : Border.all(color: AppColors.transparent),
    ),
    child: InkWell(
      onTap: onPressed,
      child: Center(
        child: child ??
            labels(
              text: text,
              color: textColor,
              size: 18,
              fontWeight: FontWeight.w600,
            ),
      ),
    ),
  );
}

Widget iconButton({
  required IconData icon,
  required Function() onTap,
  Color iconColor = AppColors.white,
  double size = 24.0,
}) {
  return IconButton(
    icon: icons(
      icon: icon,
      color: iconColor,
      size: size,
    ),
    onPressed: onTap,
  );
}

Widget filledButton({
  required String label,
  required Function() onTap,
  double? width,
  Widget? child,
}) {
  return submitButton(
    text: label,
    height: Screen.screenHeight * 0.045,
    width: width ?? Screen.screenWidth * 0.27,
    onPressed: onTap,
    textColor: AppColors.white,
    child: child,
  );
}

Widget borderButton({
  required String label,
  required Function() onTap,
  double? width,
}) {
  return submitButton(
    text: label,
    height: Screen.screenHeight * 0.045,
    width: width ?? Screen.screenWidth * 0.27,
    onPressed: onTap,
    textColor: AppColors.whiteColor,
    backgroundColor: AppColors.white,
    bColor: AppColors.blueColor,
    isBorder: true,
  );
}

Widget textButton({
  required String text,
  required Function() onTap,
}) {
  return TextButton(
    onPressed: onTap,
    child: labels(
      text: text,
      color: AppColors.blueColor,
      size: 14.0,
      fontWeight: FontWeight.w600,
    ),
  );
}
