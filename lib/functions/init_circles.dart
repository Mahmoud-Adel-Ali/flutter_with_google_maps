import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Set<Circle> circles = {};

void initCircles() {
  var circle = Circle(
    circleId: const CircleId('1'),
    center: const LatLng(26.558547000844204, 31.694578011009),
    radius: 1000,
    strokeWidth: 5,
    strokeColor: Colors.redAccent.shade100,
    fillColor: Colors.redAccent.shade100,
  );
  circles.add(circle);
}
