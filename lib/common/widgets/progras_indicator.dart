import 'package:flutter/material.dart';
import 'package:livehelp/Utils/colors.dart';
import 'package:livehelp/Utils/screen_utils.dart';

const Widget circularIndicator = Center(
  child: CircularProgressIndicator(
    color: AppColors.blueColor,
  ),
);
Widget fullScreenCircularIndicator = Container(
  height: Screen.screenHeight,
  width: Screen.screenWidth,
  color: AppColors.black12,
  child: const Center(
    child: CircularProgressIndicator(color: AppColors.white),
  ),
);
