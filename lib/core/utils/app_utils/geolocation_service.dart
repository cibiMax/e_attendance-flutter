import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as a;

class LocationUtil {
  final a.Location location;

  LocationUtil({required this.location});
  Future<bool> checkLocationEnabled() async {
    return await location.serviceEnabled();
  }

  Future<bool> requestLocationService() async {
    return await location.requestService();
  }

  Future<a.LocationData> getPosition() async {
    return await location.getLocation();
  }

  Stream<a.LocationData> onLocationChanged() {
    return location.onLocationChanged;
  }

  Future<List<Placemark>> getAddressFromPosition(
    double latitude,
    double longitude,
  ) async {
    return await placemarkFromCoordinates(latitude, longitude);
  }

  String formatPlacemark(Placemark placemark) {
    final parts = <String?>[
      placemark.name,
      placemark.street,
      placemark.subLocality,
      placemark.locality,
      placemark.subAdministrativeArea,
      placemark.administrativeArea,
      placemark.postalCode,
      placemark.country,
    ];

    return parts.where((p) => p != null && p.trim().isNotEmpty).join(',');
  }
}
