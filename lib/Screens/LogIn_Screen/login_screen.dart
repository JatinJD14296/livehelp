// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:livehelp/Screens/Home_Screen/home_screen.dart';
import 'package:livehelp/Screens/SignUp_Screen/signup_screen.dart';
import 'package:livehelp/Sevices/auth_services_data.dart';
import 'package:livehelp/Utils/colors.dart';
import 'package:livehelp/Utils/images.dart';
import 'package:livehelp/Utils/screen_utils.dart';
import 'package:livehelp/Utils/strings.dart';
import 'package:livehelp/common/validation/validation_stream_controller.dart';
import 'package:livehelp/common/validation/validation_string.dart';
import 'package:livehelp/common/widgets/buttons.dart';
import 'package:livehelp/common/widgets/field_and_label.dart';
import 'package:livehelp/common/widgets/icon_and_images.dart';
import 'package:livehelp/common/widgets/padding_margin.dart';
import 'package:livehelp/common/widgets/space_and_dividers.dart';
import 'package:livehelp/common/widgets/text_and_styles.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String nameErrorMsg = "";
  String emailErrorMsg = "";
  String passwordErrorMsg = "";
  bool passVisible = true;
  final DatabaseService _authService = DatabaseService();
  ValueNotifier userCredential = ValueNotifier('');

  @override
  void dispose() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Screen.setScreenSize(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: paddingOnly(top: 80, left: 0, right: 280),
                child: labels(
                    text: Strings.txtLogIn.toUpperCase(),
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500,
                    size: 22),
              ),
              Padding(
                padding: paddingOnly(top: 40, left: 20, right: 20),
                child: FieldAndLabel(
                  hint: errorRequiredName,
                  controller: nameController,
                  labelValue: Strings.txtName,
                  validationMessage: nameErrorMsg,
                  onChanged: (value) {
                    nameErrorMsg = nameValidationMsg(value);
                  },
                  inputType: TextInputType.name,
                ),
              ),
              Padding(
                padding: paddingOnly(top: 15, left: 20, right: 20),
                child: FieldAndLabel(
                  hint: errorRequiredEmail,
                  controller: emailController,
                  labelValue: Strings.txtEmail,
                  validationMessage: emailErrorMsg,
                  onChanged: (value) {
                    emailErrorMsg = emailValidationMsg(value);
                  },
                  inputType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: paddingOnly(top: 15, left: 20, right: 20),
                child: FieldAndLabel(
                  hint: errorRequiredPassword,
                  controller: passwordController,
                  labelValue: Strings.txtPassword,
                  validationMessage: passwordErrorMsg,
                  isPassword: passVisible,
                  inputType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      passwordErrorMsg = passwordValidationMsg(value);
                    });
                  },
                  rightIcon: iconButton(
                    onTap: () {
                      setState(() {
                        passVisible = !passVisible;
                      });
                    },
                    iconColor: AppColors.homeTextColor,
                    icon: passVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              Padding(
                  padding: paddingOnly(top: 40, left: 20, right: 20),
                  child: submitButton(
                      backgroundColor: AppColors.darkBlue,
                      height: 48,
                      width: double.infinity,
                      text: Strings.txtLogIn.toUpperCase(),
                      onPressed: () async {

                        nameErrorMsg = nameValidationMsg(nameController.text);
                        emailErrorMsg =
                            emailValidationMsg(emailController.text);
                        passwordErrorMsg =
                            passwordValidationMsg(passwordController.text);

                          if (nameController.text.isNotEmpty ||
                              emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            String email = emailController.text.trim();
                            String password = passwordController.text.trim();
                            User? user = await _authService
                                .signInWithEmailAndPassword(email, password);
                            if (user != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeScreen()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Invalid email or password'),
                              ));
                            }
                          }
                      })),
              Padding(
                padding: paddingOnly(top: 10, right: 20),
                child: GestureDetector(
                  child: labels(
                    text: Strings.txtForgotPassword,
                    color: AppColors.homeTextColor,
                  ),
                  onTap: () {},
                ),
              ),
              Padding(
                  padding: paddingOnly(top: 15, right: 20, left: 20),
                  child: labels(
                      text: Strings.txtOR, color: AppColors.homeTextColor)),
              Padding(
                padding: paddingOnly(top: 50, right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Images.instance
                          .assetImage(name: AppImage.googleImg, height: 30),
                      onTap: () async {
                        userCredential.value =
                        await DatabaseService().signInWithGoogle();
                        if (userCredential.value != null) {
                          log(userCredential.value.user!.email);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        }
                      },
                    ),
                    horizontalSpace(20),
                    GestureDetector(
                      child: Images.instance
                          .assetImage(name: AppImage.linkedinImg, height: 30),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: paddingOnly(top: 30, right: 80, left: 20),
                  child: GestureDetector(
                    child: labels(
                        text:
                            "${Strings.txtAccount} ${Strings.txtSignUp.toUpperCase()}"),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen())),
                  )),
            ],
          ),
        ),
      ),
    );
  }
// static Future<FirebaseApp> initializeFirebase({
//   required BuildContext context,
// }) async {
//   FirebaseApp firebaseApp = await Firebase.initializeApp();
//
//   User? user = FirebaseAuth.instance.currentUser;
//
//   if (user != null) {
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (context) => UserInfoScreen(
//           user: user,
//         ),
//       ),
//     );
//   }
//
//   return firebaseApp;
// }
}
