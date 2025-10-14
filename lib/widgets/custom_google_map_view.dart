import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMapView extends StatefulWidget {
  const CustomGoogleMapView({super.key});

  @override
  State<CustomGoogleMapView> createState() => _CustomGoogleMapViewState();
}

class _CustomGoogleMapViewState extends State<CustomGoogleMapView> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? mapController;
  late Location location;

  Set<Marker> markers = {};
  @override
  void initState() {
    super.initState();
    initialCameraPosition = const CameraPosition(
      target: LatLng(100, 100),
      zoom: 12,
    );
    location = Location();

    // initMarkers();
    // initPolylines();
    // initPolygons();
    // initCircles();
    updateMyLocation();
  }

  @override
  void dispose() {
    super.dispose();
    mapController?.dispose();
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
                mapController!.animateCamera(
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

    // ignore: deprecated_member_use
    mapController!.setMapStyle(nightMapStyle);
  }

  Future<void> checkAndRequestLocationService() async {
    bool isServiceEnabled = await location.serviceEnabled();

    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();

      if (!isServiceEnabled) {
        //TODO : show error bar
        return;
      }
    }
  }

  Future<bool> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      //TODO : show error bar
      return false;
    } else if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        //TODO : show error bar
        return false;
      } else {
        return true;
      }
    }
    return true;
  }

  Future<void> getLocationData() async {
    location.onLocationChanged.listen((locationData) {
      var latLng = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
      var cameraPosition = CameraPosition(target: latLng, zoom: 12);
      var myLocationMarcker = Marker(
        markerId: const MarkerId('1'),
        position: latLng,
        infoWindow: const InfoWindow(title: 'My Location'),
      );
      markers.add(myLocationMarcker);
      setState(() {});
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
    });
  }

  void updateMyLocation() async {
    await checkAndRequestLocationService();
    bool hasPermission = await checkAndRequestLocationPermission();
    if (!hasPermission) return;
    await getLocationData();
  }
}

// How to set the zoom level
// World View : 0 -> 3
// Continent View : 4 -> 
// City View : 8 -> 12
// Street View : 13 -> 17
// Building View : 18 -> 20

//=============================================
/// to access user location
/// - check if location services are enabled
/// - request permission
/// - get location
/// - Display user location on map
/// - listen to location changes 
/// 