import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as a;
import 'package:geolocator/geolocator.dart' as b;

class LocationUtil {
  final a.Location _location;

  LocationUtil({required a.Location location}) : _location = location;

  Future<bool> checkLocationEnabled() async {
    return await _location.serviceEnabled();
  }

  Future<bool> requestLocationService() async {
    return await _location.requestService();
  }

  Future<b.Position> getPosition() async {
    return await b.Geolocator.getCurrentPosition(
      locationSettings: b.LocationSettings(
        accuracy: b.LocationAccuracy.best,
        distanceFilter: 1,
        timeLimit: Duration(seconds: 30),
      ),
    );
  }

  Stream<a.LocationData> onLocationChanged() {
    return _location.onLocationChanged;
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
