import 'package:flutter/material.dart';
import 'package:livehelp/Utils/colors.dart';
import 'package:livehelp/common/widgets/appbar_widget.dart';
import 'package:livehelp/common/widgets/space_and_dividers.dart';
import 'package:livehelp/common/widgets/text_and_styles.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> teacherList = [
      {
        'label': 'Teacher 1 : Coding',
        'onTap': () {},
      },
      {
        'label': 'Teacher 2 : Marketing',
        'onTap': () {},
      },
      {
        'label': 'Teacher 3 : Life Science',
        'onTap': () {},
      },
    ];

    List<Map<String, dynamic>> teachingList = [
      {
        'label': '30 Days of Sustainability',
        'onTap': () {},
      },
      {
        'label': '30 Days of Robotics',
        'onTap': () {},
      },
      {
        'label': '30 Days of Coding',
        'onTap': () {},
      },
      {
        'label': '30 Days of Recycling',
        'onTap': () {},
      },
    ];

    return GestureDetector(
        onTap: () {
      FocusScope.of(context).requestFocus(FocusNode());
    },
    child:Scaffold(
      appBar: appbar(
        context,
        leadingIcon:  Icons.arrow_back_ios_new_sharp,
        title: 'Teacher / Teaching',
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.darkBlue,
        onPressed: () {},
        label: labels(
          text: 'Be Teacher',
          color: AppColors.white,
          size: 16,
        ),
      ),
      body: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      verticalSpace(20.0),
                      Row(
                        children: [
                          horizontalSpace(10.0),
                          labels(
                            text: 'Teacher',
                            color: AppColors.darkBlue,
                            size: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: teacherList.length,
                          itemBuilder: (context, index) => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: InkWell(
                                onTap: teacherList[index]['onTap'],
                                child: labels(
                                  text: teacherList[index]['label'].toString(),
                                  size: 17,
                                  textAlign: TextAlign.left,
                                  color: AppColors.darkBlue,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(15.0),
                divider(
                  color: AppColors.whiteColor,
                  height: 5,
                  thickness: 3,
                ),
                verticalSpace(15.0),
                Expanded(
                  child: Column(
                    children: [
                      verticalSpace(20.0),
                      Row(
                        children: [
                          horizontalSpace(10.0),
                          labels(
                            text: 'Teaching',
                            color: AppColors.darkBlue,
                            size: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: teachingList.length,
                          itemBuilder: (context, index) => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: InkWell(
                                onTap: teachingList[index]['onTap'],
                                child: labels(
                                  text: teachingList[index]['label'].toString(),
                                  size: 17,
                                  textAlign: TextAlign.left,
                                  color: AppColors.darkBlue,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),),
    );
  }
}
