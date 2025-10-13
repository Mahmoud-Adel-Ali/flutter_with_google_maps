import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Set<Polygon> polygons = {};

void initPolygons() {
  var polygon = Polygon(
    // to draw holes in polygons
    holes: const [
      [
        LatLng(26.55800060103205, 31.697322615598104),
        LatLng(26.559316417027457, 31.69567483739066),
        LatLng(26.558651536641364, 31.695643649160477),
      ]
    ],
    polygonId: const PolygonId('1'),
    points: const [
      LatLng(26.55800060103205, 31.697322615598104),
      LatLng(26.559316417027457, 31.69567483739066),
      LatLng(26.558651536641364, 31.695643649160477),
    ],
    strokeWidth: 5,
    strokeColor: Colors.greenAccent.shade200,
    fillColor: Colors.greenAccent.shade200,
  );
  polygons.add(polygon);
}
