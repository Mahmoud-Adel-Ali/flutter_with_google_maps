import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng position;

  PlaceModel({
    required this.id,
    required this.name,
    required this.position,
  });
}

List<PlaceModel> places = [
  PlaceModel(
    id: 1,
    name: 'KFC',
    position: const LatLng(26.55575770259656, 31.700052831062997),
  ),
  PlaceModel(
    id: 2,
    name: 'الشبان',
    position: const LatLng(26.5580833696787, 31.6972698390684),
  ),
  PlaceModel(
    id: 3,
    name: 'قصر الثقافة',
    position: const LatLng(26.556898431617988, 31.694728551663182),
  ),
];
