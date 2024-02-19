import 'package:flutter/material.dart';
import 'package:livehelp/Screens/Nearest_Help_Center/food_google_map_screen.dart';
import 'package:livehelp/Screens/Nearest_Help_Center/other_google_map_screen.dart';
import 'package:livehelp/Screens/Nearest_Help_Center/police_google_map_screen.dart';
import 'package:livehelp/common/widgets/appbar_widget.dart';
import 'package:livehelp/common/widgets/container_widget.dart';
import 'hospital_google_map_screen.dart';

class NearestHelpCenterScreen extends StatefulWidget {
  const NearestHelpCenterScreen({super.key});

  @override
  State<NearestHelpCenterScreen> createState() =>
      _NearestHelpCenterScreenState();
}

class _NearestHelpCenterScreenState extends State<NearestHelpCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          appBar: appbar(
            context,
            title: "Nearest Help Center",
            leadingIcon: Icons.arrow_back_ios_new_sharp,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                listContainer(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HospitalGoogleMapScreen()));
                      });
                    },
                    label: "Hospital Near Me"),
                listContainer(onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PoliceGoogleMapScreen()));
                  });
                }, label: "Police Station"),
                listContainer(onTap: () {setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HospitalGoogleMapScreen()));
                });}, label: "Blood Bank"),
                listContainer(onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FoodGoogleMapScreen()));
                  });
                }, label: "Food Bank"),
                listContainer(onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OtherGoogleMapScreen()));
                  });
                }, label: "Shelter Bank"),
                listContainer(onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HospitalGoogleMapScreen()));
                  });
                }, label: "Donation Bank"),
                listContainer(onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OtherGoogleMapScreen()));
                  });
                }, label: "Animal NGOs"),
                listContainer(onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OtherGoogleMapScreen()));
                  });
                }, label: "NGOs for Humans"),
              ],
            ),
          )),
    );
  }
}
