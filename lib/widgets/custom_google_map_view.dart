import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Set<Polyline> polylines = {};
  Set<Polygon> polygons = {};

  @override
  void initState() {
    super.initState();
    initMarkers();
    initialCameraPosition = const CameraPosition(
      target: LatLng(100, 100),
      zoom: 12,
    );

    initPolylines();
    initPolygons();
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
            polygons: polygons,
            polylines: polylines,
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
                    const LatLng(29.8552649548856, 29.8552649548856),
                  ),
                );
              },
              child: const Text('Zoom In'),
            ),
          ),
        ],
      ),
    );
  }

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/map_styles/night_map_style.json');

    mapController.setMapStyle(nightMapStyle);
  }

  Future<Uint8List> getImageFromRowData(String image, double width) async {
    ByteData data = await rootBundle.load(image);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width.toInt(),
    );
    ui.FrameInfo imageFram = await codec.getNextFrame();
    var imageByteData = await imageFram.image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return imageByteData!.buffer.asUint8List();
  }

  void initMarkers() async {
    var markerIcon = BitmapDescriptor.bytes(
      await getImageFromRowData('assets/images/marker_icon.png', 150),
    );
    places.map((place) {
      markers.add(
        Marker(
          markerId: MarkerId(place.id.toString()),
          infoWindow: InfoWindow(title: place.name),
          position: place.position,
          icon: markerIcon,
        ),
      );
    });
  }

  void initPolylines() {
    const polyline = Polyline(
      polylineId: PolylineId('1'),
      points: [
        LatLng(26.55800060103205, 31.697322615598104),
        LatLng(26.559316417027457, 31.69567483739066),
        LatLng(26.558651536641364, 31.695643649160477),
      ],
      color: Colors.amber,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      geodesic: true, // true means the polyline is a geodesic , not straight
      patterns: [PatternItem.dot],
    );
    polylines.add(polyline);
  }

  void initPolygons() {
    const polygon = Polygon(
      // to draw holes in polygons
      holes: [
        [
          LatLng(26.55800060103205, 31.697322615598104),
          LatLng(26.559316417027457, 31.69567483739066),
          LatLng(26.558651536641364, 31.695643649160477),
        ]
      ],
      polygonId: PolygonId('1'),
      points: [
        LatLng(26.55800060103205, 31.697322615598104),
        LatLng(26.559316417027457, 31.69567483739066),
        LatLng(26.558651536641364, 31.695643649160477),
      ],
      strokeWidth: 5,
      strokeColor: Colors.greenAccent,
      fillColor: Colors.greenAccent,
    );
    polygons.add(polygon);
  }
}

// How to set the zoom level
// World View : 0 -> 3
// Continent View : 4 -> 
// City View : 8 -> 12
// Street View : 13 -> 17
// Building View : 18 -> 20