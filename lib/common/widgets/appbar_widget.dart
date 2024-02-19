import 'package:flutter/material.dart';
import 'package:livehelp/Utils/colors.dart';
import 'package:livehelp/common/widgets/buttons.dart';
import 'text_and_styles.dart';

PreferredSizeWidget appbar(
  BuildContext context, {
  String title = '',
  IconData? leadingIcon,
  Widget? actionIcons,
  Color bgColor = AppColors.darkBlue,
}) {
  return AppBar(
    title: labels(
      text: title.toUpperCase(),
      color: AppColors.whiteColor,
      fontWeight: FontWeight.bold,
      size: 25.0,
    ),
    leading: leadingIcon
        == null
        ? Container()
        : iconButton(
            icon: leadingIcon,iconColor: AppColors.whiteColor,
            onTap: () {
              Navigator.pop(context);
            },
          ),
    actions: [actionIcons ?? Container()],
    backgroundColor: bgColor,
    centerTitle: true,
  );
}
