// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:livehelp/Utils/colors.dart';
import 'package:livehelp/Utils/strings.dart';
import 'package:livehelp/common/widgets/icon_and_images.dart';
import 'field_and_label.dart';

String dateFormat({DateTime? dateTime, String format = 'dd/MM/yyyy'}) =>
    DateFormat(format).format(dateTime ?? DateTime.now());

DateTime stringToDate(String date) => DateFormat('dd/MM/yyyy').parse(date);

Widget textFieldWithDatePicker(
  context, {
  required TextEditingController controller,
  required String label,
  String error = '',
  String text = '',
  bool click = true,
}) {
  return FieldAndLabel(
    onChanged: (val) {},
    readOnly: true,
    hint:Strings.txtDateFormat,
    labelValue: label,
    controller: controller..text = text,
    fillColor: AppColors.white,
    validationMessage: error,
    onTap: (click)
        ? () async {
            await showDatePicker(
              context: context,
              lastDate: DateTime(DateTime.now().year + 1),
              firstDate: DateTime(1960),
              initialDate: DateTime.now(),
            ).then((value) => controller.text = dateFormat(dateTime: value));
          }
        : null,
    rightIcon: icons(icon: Icons.calendar_today_outlined),
  );
}
