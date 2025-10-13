import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter_with_google_maps/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Set<Marker> markers = {};

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
