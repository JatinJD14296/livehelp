import 'package:flutter/material.dart';
import '../../utils/colors.dart';

Widget listContainer({
  String? path,
  String? label = '',
  double? height,
  double? width,
  required Function() onTap,
}) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        width: double.infinity,
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.darkBlue,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: const [
              BoxShadow(
                blurRadius: 5.0,
                color: AppColors.black,
                offset: Offset(0, 5),
              ),
            ]),
        child:
              Center(
                child: Text(
                  label!,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor),
                ),
        ),
      ),
    );

