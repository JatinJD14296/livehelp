// ignore_for_file: deprecated_member_use

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:livehelp/Utils/colors.dart';
import 'package:livehelp/Utils/images.dart';
import 'package:livehelp/Utils/strings.dart';
import 'package:livehelp/common/validation/validation_string.dart';
import 'package:livehelp/common/widgets/appbar_widget.dart';
import 'package:livehelp/common/widgets/field_and_label.dart';
import 'package:livehelp/common/widgets/icon_and_images.dart';
import 'package:livehelp/common/widgets/padding_margin.dart';
import 'package:livehelp/common/widgets/progras_indicator.dart';
import 'package:livehelp/common/widgets/space_and_dividers.dart';

enum GenderRadio { male, female, other }

class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  var selectedValue = GenderRadio.male;
  final DatabaseReference _userRef =
      FirebaseDatabase.instance.reference().child('users');

  @override
  void dispose() {
    emailController.clear();
    nameController.clear();
    mobileNumberController.clear();
    bloodGroupController.clear();
    addressController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            appBar: appbar(
              context,
              title: Strings.txtProfile,
              leadingIcon: Icons.arrow_back_ios_new_sharp,
            ),
            body: StreamBuilder(
              stream: _userRef.child(widget.userId).onValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return circularIndicator;
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData ||
                    snapshot.data!.snapshot.value == null) {
                  return const Text('No data available');
                }

                Map<dynamic, dynamic>? userData =
                    snapshot.data!.snapshot.value as Map?;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(20),
                      Center(
                        child: Images.instance.assetImage(
                          name: AppImage.appLogo,
                          height: 160,
                          color: AppColors.black,
                        ),
                      ),
                      Padding(
                        padding: paddingOnly(top: 40, left: 20, right: 20),
                        child: FieldAndLabel(
                          hint: errorRequiredName,
                          controller:
                              TextEditingController(text: userData!['name']),
                          labelValue: Strings.txtName,
                          inputType: TextInputType.name,
                        ),
                      ),
                      Padding(
                        padding: paddingOnly(top: 15, left: 20, right: 20),
                        child: FieldAndLabel(
                          hint: errorRequiredEmail,
                          controller:
                              TextEditingController(text: userData['email']),
                          labelValue: Strings.txtEmail,
                          readOnly: true,
                        ),
                      ),
                      Padding(
                        padding: paddingOnly(top: 15, left: 20, right: 20),
                        child: FieldAndLabel(
                          hint: errorRequiredMobileNumber,
                          controller: TextEditingController(
                              text: userData['mobileNumber']),
                          labelValue: Strings.txtPhoneNumber,
                          readOnly: true,
                        ),
                      ),
                      Padding(
                        padding: paddingOnly(top: 15, left: 20, right: 20),
                        child: FieldAndLabel(
                          hint: errorValidAddress,
                          controller:
                              TextEditingController(text: userData['address']),
                          labelValue: Strings.txtAddress,
                          readOnly: true,
                          maxLine: 2,
                        ),
                      ),
                      Padding(
                        padding: paddingOnly(top: 15, left: 20, right: 20),
                        child: FieldAndLabel(
                          hint: errorValidAddress,
                          controller:
                              TextEditingController(text: userData['gender']),
                          labelValue: Strings.txtGender,
                          readOnly: true,
                        ),
                      ),
                      Padding(
                        padding: paddingOnly(top: 15, left: 20, right: 20),
                        child: FieldAndLabel(
                          hint: errorValidAddress,
                          controller: TextEditingController(
                              text: userData['bloodGroup']),
                          labelValue: Strings.txtBloodGroup,
                          readOnly: true,
                        ),
                      ),
                    ],
                  ),
                );
              },
            )));
  }
}
