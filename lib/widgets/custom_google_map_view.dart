import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMapView extends StatefulWidget {
  const CustomGoogleMapView({super.key});

  @override
  State<CustomGoogleMapView> createState() => _CustomGoogleMapViewState();
}

class _CustomGoogleMapViewState extends State<CustomGoogleMapView> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController mapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    initMarkers();
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
      body: Stack(
        children: [
          GoogleMap(
            markers: markers,
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (controller) {
              mapController = controller;
              initMapStyle();
            },
            // camera target bounds is used to limit the zoom level & position
            // and it take two axis points
            // cameraTargetBounds: CameraTargetBounds(LatLngBounds(
            //   northeast: const LatLng(100, 100),
            //   southwest: const LatLng(100, 100),
            // )),
          ),
          Positioned(
            bottom: 24,
            right: 64,
            left: 64,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade300,
              ),
              onPressed: () {
                mapController.animateCamera(
                  // CameraUpdate.newCameraPosition(cameraPosition)
                  CameraUpdate.newLatLng(
                      const LatLng(29.8552649548856, 29.8552649548856)),
                );
              },
              child: const Text('Zoom In'),
            ),
          )
        ],
      ),
    );
  }

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_styles/night_map_style.json');

    mapController.setMapStyle(nightMapStyle);
  }

  void initMarkers() {
    places.map((place) {
      markers.add(
        Marker(
          markerId: MarkerId(place.id.toString()),
          position: place.position,
          infoWindow: InfoWindow(title: place.name),
        ),
      );
    });
  }
}

// How to set the zoom level
// World View : 0 -> 3
// Continent View : 4 -> 
// City View : 8 -> 12
// Street View : 13 -> 17
// Building View : 18 -> 20