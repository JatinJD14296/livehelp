import 'package:flutter/material.dart';
import 'package:livehelp/Utils/colors.dart';
import 'package:livehelp/Utils/images.dart';
import 'package:livehelp/Utils/strings.dart';
import 'package:livehelp/common/widgets/icon_and_images.dart';
import 'package:livehelp/common/widgets/space_and_dividers.dart';
import 'package:livehelp/common/widgets/text_and_styles.dart';

Widget noDataFoundWidget = Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Images.instance.assetImage(
        name: AppImage.noDataFound,
        color: AppColors.primaryColor,
      ),
      verticalSpace(20.0),
      labels(
        text:Strings.txtDataNotFount,
        color: AppColors.primaryColor,
        size: 20.0,
      ),
    ],
  ),
);
