import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  Location location = Location();
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  Future<void> fetchLocation() async {
    LocationData locationData = await location.getLocation();
    setState(() {
      markers.add(
        Marker(
          markerId: const MarkerId('current_user'),
          position: LatLng(locationData.latitude!, locationData.longitude!),
          infoWindow: const InfoWindow(title: 'Your Location'),
        ),
      );
      // Add another person's location marker
      markers.add(
        const Marker(
          markerId: MarkerId('second_person'),
          position: LatLng(23.0387, 72.5119), // Example coordinates for New York City
          infoWindow: InfoWindow(title: 'Second Person'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Screen'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0), // Center the map initially at 0,0
          zoom: 10,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        markers: markers,
        polylines: {
          const Polyline(
            polylineId: PolylineId('line'),
            color: Colors.blue,
            points: [
              LatLng(23.0120, 72.5108), // Starting point (example: New York City)
              LatLng(23.0387, 72.5119), // Ending point (example: San Francisco)
            ],
          ),
        },
      ),
    );
  }
}
