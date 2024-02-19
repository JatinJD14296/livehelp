// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:livehelp/Screens/Education_Screen/education_screen.dart';
import 'package:livehelp/Screens/Emergency_Contact_Screen/emergency_contact_screen.dart';
import 'package:livehelp/Screens/LogIn_Screen/login_screen.dart';
import 'package:livehelp/Screens/Message_Screen/message_screen.dart';
import 'package:livehelp/Screens/Nearest_Help_Center/nearest_help_center_screen.dart';
import 'package:livehelp/Screens/Profile_Screen/profile_screen.dart';
import 'package:livehelp/Sevices/auth_services_data.dart';
import 'package:livehelp/Utils/colors.dart';
import 'package:livehelp/Utils/images.dart';
import 'package:livehelp/Utils/strings.dart';
import 'package:livehelp/common/widgets/icon_and_images.dart';
import 'package:livehelp/common/widgets/text_and_styles.dart';

Widget drawerWidget(BuildContext context) {
  ValueNotifier userCredential = ValueNotifier('');
  getUserId() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      String uid = user.uid;
      log("===$uid");
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => ProfileScreen(userId: uid)));
    } else {
      return null;
    }
  }

  return Drawer(
    backgroundColor: AppColors.darkBlue,
    child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: Images.instance.assetImageProvider(AppImage.appLogo))),
          child: const Text(""),
        ),
        ListTile(
            leading: icons(
                icon: Icons.person, color: AppColors.whiteColor, size: 30),
            title: labels(
                text: Strings.txtProfile,
                color: AppColors.whiteColor,
                size: 22),
            onTap: () => getUserId()),
        ListTile(
          leading: icons(
              icon: Icons.notifications_active,
              color: AppColors.whiteColor,
              size: 30),
          title: labels(
              text: Strings.txtNotification,
              color: AppColors.whiteColor,
              size: 22),
          onTap: () => {},
        ),
        ListTile(
          leading:
              icons(icon: Icons.help, color: AppColors.whiteColor, size: 30),
          title: labels(
              text: Strings.txtLiveHelpMessage,
              color: AppColors.whiteColor,
              size: 22),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MessageScreen())),
        ),
        ListTile(
          leading: icons(
              icon: Icons.location_on_rounded,
              color: AppColors.whiteColor,
              size: 30),
          title: labels(
              text: Strings.txtNearestLocation,
              color: AppColors.whiteColor,
              size: 22,
              maxLine: 2),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NearestHelpCenterScreen())),
        ),
        ListTile(
          leading:
              icons(icon: Icons.book, color: AppColors.whiteColor, size: 30),
          title: labels(
              text: Strings.txtEducation,
              color: AppColors.whiteColor,
              size: 22),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EducationScreen())),
        ),
        ListTile(
          leading:
              icons(icon: Icons.call, color: AppColors.whiteColor, size: 30),
          title: labels(
              text: Strings.txtEmergency,
              color: AppColors.whiteColor,
              size: 22),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EmergencyContactScreen())),
        ),
        ListTile(
          leading:
              icons(icon: Icons.logout, color: AppColors.whiteColor, size: 30),
          title: labels(
              text: Strings.txtLogOut, color: AppColors.whiteColor, size: 22),
          onTap: () async {
            bool result = await DatabaseService().signOutFromGoogle();
            if (result) {
              userCredential.value = '';
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LogInScreen()));
            }
          },
        ),
      ],
    ),
  );
}
