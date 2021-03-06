import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({Key? key}) : super(key: key);

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  //Google map
  late GoogleMapController mapController;
  final LatLng _position = const LatLng(10.682024, 122.954228);

  // set the location when the map created
  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    Position currentPosition = await Geolocator.getCurrentPosition();

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentPosition.latitude, currentPosition.longitude),
        zoom: 70)));

    // // listen for the location
    // Position currentLocation =  Geolocator.getCurrentPosition();
    // widget.location.onLocationChanged.listen((l) {
    //   mapController.animateCamera(CameraUpdate.newCameraPosition(
    //       CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 70)));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          border: Border.all(width: 3, color: const Color(0xffFDBF05)),
          borderRadius: const BorderRadius.all(Radius.circular(25))),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20)),
        child: GoogleMap(
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(target: _position, zoom: 70),
          myLocationEnabled: true,
        ),
      ),
    );
  }
}
