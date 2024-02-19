// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:livehelp/Screens/Help_Screen/help_screen.dart';
import 'package:livehelp/Screens/Home_Screen/drawer_screen.dart';
import 'package:livehelp/Utils/colors.dart';
import 'package:livehelp/Utils/strings.dart';
import 'package:livehelp/common/widgets/buttons.dart';
import 'package:livehelp/common/widgets/field_and_label.dart';
import 'package:livehelp/common/widgets/padding_margin.dart';
import 'package:livehelp/common/widgets/text_and_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController mapController;
   LatLng? _center;
  late Position currentPosition;


  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = position;
      _center = LatLng(position.latitude, position.longitude);
    });
  }
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        drawer: drawerWidget(context),
        drawerScrimColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.darkBlue,
          centerTitle: true,
          title: labels(
            text: Strings.txtLiveHelp.toUpperCase(),
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            size: 25.0,
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: AppColors.whiteColor),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: paddingOnly(top: 20, left: 20, right: 20),
                child: FieldAndLabel(
                  hint: "Please enter and search",
                  controller: searchController,
                  labelValue: Strings.txtSearch,
                  inputType: TextInputType.text,
                  rightIcon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                  isRequire: false,
                ),
              ),
              Padding(
                padding: paddingOnly(top: 20, left: 20, right: 20),
                child: SizedBox(
                  height: 450,
                  width: double.infinity,
                  child:_center == null
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center!,
                      zoom: 15.0,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('current'),
                        position: _center!,
                        infoWindow: const InfoWindow(
                          title: 'Current Location',
                          snippet: 'This is your current location.',
                        ),
                      ),
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: paddingOnly(top: 10, left: 20),
                    child: submitButton(
                        height: 48,
                        width: 90,
                        text: Strings.txtHelp,
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HelpScreen())),
                        backgroundColor: AppColors.green),
                  ),
                  Padding(
                    padding: paddingOnly(
                      top: 10,
                    ),
                    child: submitButton(
                        height: 48,
                        width: 90,
                        text: "Police",
                        onPressed: () {},
                        backgroundColor: AppColors.red),
                  ),
                  Padding(
                    padding: paddingOnly(top: 10, right: 20),
                    child: submitButton(
                        height: 48,
                        width: 90,
                        text: "Hospital",
                        onPressed: () {},
                        backgroundColor: AppColors.homeMapCircleColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
