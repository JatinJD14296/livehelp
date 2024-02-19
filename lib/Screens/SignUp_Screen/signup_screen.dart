// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:livehelp/Screens/Home_Screen/home_screen.dart';
import 'package:livehelp/Screens/LogIn_Screen/login_screen.dart';
import 'package:livehelp/Sevices/auth_services_data.dart';
import 'package:livehelp/Utils/colors.dart';
import 'package:livehelp/Utils/images.dart';
import 'package:livehelp/Utils/strings.dart';
import 'package:livehelp/common/validation/validation_stream_controller.dart';
import 'package:livehelp/common/validation/validation_string.dart';
import 'package:livehelp/common/widgets/buttons.dart';
import 'package:livehelp/common/widgets/field_and_label.dart';
import 'package:livehelp/common/widgets/icon_and_images.dart';
import 'package:livehelp/common/widgets/padding_margin.dart';
import 'package:livehelp/common/widgets/space_and_dividers.dart';
import 'package:livehelp/common/widgets/text_and_styles.dart';

enum GenderRadio { male, female, other }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController aadharCardController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  var selectedValue = GenderRadio.male;
  ValueNotifier userCredential = ValueNotifier('');

  @override
  void dispose() {
    passwordController.clear();
    nationalityController.clear();
    aadharCardController.clear();
    emailController.clear();
    nameController.clear();
    mobileNumberController.clear();
    bloodGroupController.clear();
    addressController.clear();
    super.dispose();
  }

  String nameErrorMsg = "";
  String emailErrorMsg = "";
  String addressErrorMsg = "";
  String passwordErrorMsg = "";
  String nationalityErrorMsg = "";
  String mobileNumberErrorMsg = "";
  String aadharCardErrorMsg = "";
  bool passVisible = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: paddingOnly(top: 80, left: 20, right: 260),
                child: labels(
                    text: Strings.txtSignUp.toUpperCase(),
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500,
                    size: 22),
              ),
              Padding(
                padding: paddingOnly(top: 40, left: 20, right: 20),
                child: FieldAndLabel(
                  hint: errorRequiredName,
                  controller: nameController,
                  isRequire: true,
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
                  isRequire: true,
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
                  isRequire: true,
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
                padding: paddingOnly(top: 15, left: 20, right: 20),
                child: FieldAndLabel(
                  hint: errorValidAddress,
                  controller: addressController,
                  labelValue: Strings.txtAddress,
                  validationMessage: addressErrorMsg,
                  onChanged: (value) {
                    addressErrorMsg = addressValidationMsg(value);
                  },
                  inputType: TextInputType.text,
                  isRequire: true,
                  maxLine: 2,
                ),
              ),
              Padding(
                padding: paddingOnly(top: 15, left: 20, right: 20),
                child: FieldAndLabel(
                  hint: errorValidAadharCard,
                  controller: aadharCardController,
                  labelValue: Strings.txtAadharCard,
                  validationMessage: addressErrorMsg,
                  onChanged: (value) {
                    aadharCardErrorMsg = aadharCardValidationMsg(value);
                  },
                  inputType: TextInputType.number,
                  isRequire: true,
                  maxLength: 12,
                ),
              ),
              Padding(
                padding: paddingOnly(top: 15, left: 20, right: 20),
                child: labels(text: Strings.txtGender, size: 18),
              ),
              RadioListTile(
                  title: const Text('Male'),
                  value: GenderRadio.male,
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  }),
              RadioListTile(
                  title: const Text('Female'),
                  value: GenderRadio.female,
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  }),
              RadioListTile(
                  title: const Text('Other'),
                  value: GenderRadio.other,
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  }),
              Padding(
                  padding: paddingOnly(top: 20, left: 20, right: 20),
                  child: DropdownButtonHideUnderline(
                    child: FieldAndLabel(
                      controller: bloodGroupController,
                      readOnly: true,
                      rightIcon: DropdownButton<String>(
                        icon: Padding(
                          padding: paddingOnly(right: 10),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 30,
                            color: AppColors.homeTextColor,
                          ),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            bloodGroupController.text = newValue!;
                          });
                        },
                        items: <String>[
                          "O+",
                          "O-",
                          "A+",
                          "A-",
                          "B+",
                          "B-",
                          "AB+",
                          "AB-"
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          );
                        }).toList(),
                      ),
                      labelValue: Strings.txtBloodGroup,
                      isRequire: true,
                      hint: 'Please Select Blood Group Value',
                    ),
                  )),
              Padding(
                padding: paddingOnly(top: 15, left: 20, right: 20),
                child: FieldAndLabel(
                  hint: errorValidNationality,
                  controller: nationalityController,
                  labelValue: Strings.txtNationality,
                  validationMessage: nationalityErrorMsg,
                  onChanged: (value) {
                    nationalityErrorMsg = nationalityValidationMsg(value);
                  },
                  inputType: TextInputType.text,
                  isRequire: true,
                ),
              ),
              Padding(
                padding: paddingOnly(top: 15, left: 20, right: 20),
                child: FieldAndLabel(
                  hint: errorRequiredMobileNumber,
                  controller: mobileNumberController,
                  labelValue: Strings.txtPhoneNumber,
                  validationMessage: mobileNumberErrorMsg,
                  onChanged: (value) {
                    mobileNumberErrorMsg = mobileValidationMsg(value);
                  },
                  inputType: TextInputType.number,
                  isRequire: true,
                  maxLength: 10,
                ),
              ),
              Padding(
                  padding: paddingOnly(top: 40, left: 20, right: 20),
                  child: submitButton(
                      backgroundColor: AppColors.darkBlue,
                      height: 48,
                      width: double.infinity,
                      text: Strings.txtSignUp.toUpperCase(),
                      onPressed: () {
                        setState(() {
                          nameErrorMsg = nameValidationMsg(nameController.text);
                          emailErrorMsg =
                              emailValidationMsg(emailController.text);
                          passwordErrorMsg =
                              passwordValidationMsg(passwordController.text);
                          addressErrorMsg =
                              addressValidationMsg(addressController.text);
                          aadharCardErrorMsg = aadharCardValidationMsg(
                              aadharCardController.text);
                          nationalityErrorMsg = nationalityValidationMsg(
                              nationalityController.text);
                          mobileNumberErrorMsg =
                              mobileValidationMsg(mobileNumberController.text);
                          if (nameController.text.isNotEmpty &&
                              emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty &&
                              addressController.text.isNotEmpty &&
                              aadharCardController.text.isNotEmpty &&
                              nationalityController.text.isNotEmpty &&
                              mobileNumberController.text.isNotEmpty &&
                              bloodGroupController.text.isNotEmpty) {
                            DatabaseService().signUp(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              address: addressController.text,
                              gender: selectedValue.name,
                              bloodGroup: bloodGroupController.text,
                              nationality: nationalityController.text,
                              mobileNumber: mobileNumberController.text,
                              aadharCard: aadharCardController.text,
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LogInScreen()));
                          }
                        });
                      })),
              Padding(
                  padding: paddingOnly(top: 20, right: 20, left: 20),
                  child: labels(
                      text: Strings.txtOR, color: AppColors.homeTextColor)),
              Padding(
                padding: paddingOnly(top: 40, right: 20, left: 20),
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
                  padding: paddingOnly(top: 30, right: 20, left: 90),
                  child: GestureDetector(
                    child: labels(
                        text:
                            "${Strings.txtAlreadyUser} ${Strings.txtLogIn.toUpperCase()}"),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LogInScreen())),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

