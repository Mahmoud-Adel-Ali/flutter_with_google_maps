import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'google_map/google_map_view.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      // builder: (context) => const TestGoogleMapwithFlutter(),
      builder: (context) => const RouteTrackerApp(),
    ),
  );
}


// class TestGoogleMapwithFlutter extends StatelessWidget {
//   const TestGoogleMapwithFlutter({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const CustomGoogleMapView(),
//     );
//   }
// }

class RouteTrackerApp extends StatelessWidget {
  const RouteTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const GoogleMapView(),
    );
  }
}