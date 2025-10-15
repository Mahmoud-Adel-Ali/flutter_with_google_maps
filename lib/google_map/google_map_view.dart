import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'exceptions/location_permission_exception.dart';
import 'exceptions/location_service_exception.dart';
import 'service/location_service.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  late CameraPosition initialCameraPosition;
  late LocationService locationService;
  late GoogleMapController mapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    initialCameraPosition = const CameraPosition(target: LatLng(0, 0));
    locationService = LocationService();
    updateCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GoogleMap(
          markers: markers,
          initialCameraPosition: initialCameraPosition,
          zoomControlsEnabled: false,
          onMapCreated: (controller) {
            mapController = controller;
            updateCurrentLocation();
          },
        ),
      ),
    );
  }

  void updateCurrentLocation() async {
    try {
      var locationData = await locationService.getLocation();
      var latLng = LatLng(locationData.latitude!, locationData.longitude!);
      setMyLocationMarcker(latLng);
      var cameraPosition = CameraPosition(target: latLng, zoom: 16);
      mapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    } on LocationServiceException catch (e) {
      log("LocationServiceException $e");
    } on LocationPermissionException catch (e) {
      log("LocationPermissionException $e");
    } catch (e) {
      log("Exception $e");
    }
  }

  void setMyLocationMarcker(LatLng latLng) {
    var myLocationMarcker = Marker(
      markerId: const MarkerId('1'),
      position: latLng,
      infoWindow: const InfoWindow(title: 'My Location'),
    );
    markers.add(myLocationMarcker);
    setState(() {});
  }
}
