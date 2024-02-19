// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class PoliceGoogleMapScreen extends StatefulWidget {
  const PoliceGoogleMapScreen({super.key});

  @override
  _PoliceGoogleMapScreenState createState() => _PoliceGoogleMapScreenState();
}

class _PoliceGoogleMapScreenState extends State<PoliceGoogleMapScreen> {
  late GoogleMapController mapController;
  LatLng? _center;
  late final List<Marker> _markers = [];

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
      _center = LatLng(position.latitude, position.longitude);
    });
    _getNearbyHospitals(position.latitude, position.longitude);
  }

  Future<void> _getNearbyHospitals(double latitude, double longitude) async {
    final placesApiUrl =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude%2C$longitude&radius=2000&type=police&key=AIzaSyCWc32AivTpwqKcVQ6Z32l4NupqdBs_-1w";
    final response = await http.get(Uri.parse(placesApiUrl));
    final data = json.decode(response.body);
    final List<dynamic> places = data['results'];

    setState(() {
      _markers.clear();
      for (var place in places) {
        final name = place['name'];
        final location = place['geometry']['location'];
        final lat = location['lat'];
        final lng = location['lng'];
        final latLng = LatLng(lat, lng);
        _markers.add(Marker(
          markerId: MarkerId(name),
          position: latLng,
          infoWindow: InfoWindow(title: name),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _center == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center!,
          zoom: 15.0,
        ),
        markers: Set.from(_markers),
      ),
    );
  }
}
