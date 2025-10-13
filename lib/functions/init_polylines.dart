import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Set<Polyline> polylines = {};

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
