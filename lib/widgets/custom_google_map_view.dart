import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMapView extends StatefulWidget {
  const CustomGoogleMapView({super.key});

  @override
  State<CustomGoogleMapView> createState() => _CustomGoogleMapViewState();
}

class _CustomGoogleMapViewState extends State<CustomGoogleMapView> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    initialCameraPosition =
        const CameraPosition(target: LatLng(100, 100), zoom: 12);
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        onMapCreated: (controller) => mapController = controller,
        // camera target bounds is used to limit the zoom level & position
        // and it take two axis points
        // cameraTargetBounds: CameraTargetBounds(LatLngBounds(
        //   northeast: const LatLng(100, 100),
        //   southwest: const LatLng(100, 100),
        // )),
      ),
    );
  }
}

// How to set the zoom level
// World View : 0 -> 3
// Continent View : 4 -> 
// City View : 8 -> 12
// Street View : 13 -> 17
// Building View : 18 -> 20