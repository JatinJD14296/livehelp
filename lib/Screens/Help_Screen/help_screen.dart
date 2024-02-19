import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:livehelp/Utils/strings.dart';
import 'package:livehelp/common/widgets/appbar_widget.dart';
import 'package:livehelp/common/widgets/buttons.dart';
import 'package:livehelp/common/widgets/padding_margin.dart';
import 'package:livehelp/common/widgets/text_and_styles.dart';
import 'package:livehelp/utils/colors.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
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
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = position;
      _center = LatLng(position.latitude, position.longitude);
    });
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
          title: Strings.txtHelp,
          leadingIcon: Icons.arrow_back_ios_new_sharp,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: paddingOnly(top: 20, left: 20, right: 20),
                child: SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: _center == null
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
              Padding(
                  padding: paddingOnly(top: 20, left: 20, right: 20),
                  child: labels(
                      text: "Choose Help :",
                      fontWeight: FontWeight.w500,
                      size: 21)),
              Padding(
                padding: paddingOnly(top: 20, left: 20, right: 20),
                child: submitButton(
                    width: double.infinity,
                    text: Strings.txtNeedFood,
                    onPressed: () {},
                    backgroundColor: AppColors.darkBlue),
              ),
              Padding(
                padding: paddingOnly(top: 20, left: 20, right: 20),
                child: submitButton(
                    width: double.infinity,
                    text: Strings.txtPoliceHelp,
                    onPressed: () {},
                    backgroundColor: AppColors.darkBlue),
              ),
              Padding(
                padding: paddingOnly(top: 20, left: 20, right: 20),
                child: submitButton(
                    width: double.infinity,
                    text: Strings.txtHospitalEmergency,
                    onPressed: () {},
                    backgroundColor: AppColors.darkBlue),
              ),
              Padding(
                padding: paddingOnly(top: 20, left: 20, right: 20),
                child: submitButton(
                    width: double.infinity,
                    text: Strings.txtAnimalHelp,
                    onPressed: () {},
                    backgroundColor: AppColors.darkBlue),
              ),
              Padding(
                padding: paddingOnly(top: 20, left: 20, right: 20),
                child: submitButton(
                    width: double.infinity,
                    text: Strings.txtAccident,
                    onPressed: () {},
                    backgroundColor: AppColors.darkBlue),
              ),
              Padding(
                padding: paddingOnly(top: 20, left: 20, right: 20),
                child: submitButton(
                    width: double.infinity,
                    text: Strings.txtCleanAreaHelp,
                    onPressed: () {},
                    backgroundColor: AppColors.darkBlue),
              ),
              Padding(
                padding: paddingOnly(top: 20, left: 20, right: 20),
                child: submitButton(
                    width: double.infinity,
                    text: Strings.txtWomanHelp,
                    onPressed: () {},
                    backgroundColor: AppColors.darkBlue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
