import 'package:flutter/material.dart';
import 'package:livehelp/Utils/colors.dart';
import 'package:livehelp/Utils/strings.dart';
import 'package:livehelp/common/widgets/appbar_widget.dart';
import 'package:livehelp/common/widgets/icon_and_images.dart';
import 'package:livehelp/common/widgets/text_and_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyContactScreen extends StatefulWidget {
  const EmergencyContactScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyContactScreen> createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> helpsList = [
      {
        'label': Strings.txtAccident,
        'contact': '100',
        'onTap': () {
          launchUrl(Uri.parse('tel:100'));
        },
      },
      {
        'label': 'Ambulance',
        'contact': '108',
        'onTap': () {
          launchUrl(Uri.parse('tel:108'));
        },
      },
      {
        'label': Strings.txtWomanHelp,
        'contact': '1088',
        'onTap': () {
          launchUrl(Uri.parse('tel:1088'));
        },
      },
      {
        'label': 'Fire in Open',
        'contact': '111',
        'onTap': () {
          launchUrl(Uri.parse('tel:111'));
        },
      },
      {
        'label': Strings.txtPoliceHelp,
        'contact': '100',
        'onTap': () {
          launchUrl(Uri.parse('tel:100'));
        },
      },
      {
        'label': 'Clean-Up',
        'contact': '200',
        'onTap': () {
          launchUrl(Uri.parse('tel:200'));
        },
      },
      {
        'label': Strings.txtAnimalHelp,
        'contact': '202',
        'onTap': () {
          launchUrl(Uri.parse('tel:202'));
        },
      },
      {
        'label': 'Human Rights',
        'contact': '222',
        'onTap': () {
          launchUrl(Uri.parse('tel:222'));
        },
      },
    ];

    return GestureDetector(
        onTap: () {
      FocusScope.of(context).requestFocus(FocusNode());
    },
    child:Scaffold(
      appBar: appbar(
        context,
        title: Strings.txtLiveHelp,
        leadingIcon:  Icons.arrow_back_ios_new_sharp,
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: helpsList
                .map(
                  (e) => InkWell(
                    onTap: e['onTap'],
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(10.0),
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            labels(
                              text: e['label'].toString(),
                              maxLine: 3,
                              size: 17,
                              color: AppColors.whiteColor,
                            ),
                            Expanded(
                              child: labels(
                                text: ' : ',
                                size: 17,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            icons(
                              icon: Icons.phone,
                              color: AppColors.whiteColor,
                            ),
                            labels(
                              text: '  ${e['contact']}',
                              maxLine: 3,
                              size: 17,
                              color: AppColors.whiteColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      )),
    );
  }
}
