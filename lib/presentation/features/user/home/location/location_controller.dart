import 'dart:async';

import 'package:e_attendance/core/utils/app_utils/geolocation_service.dart';
import 'package:e_attendance/core/utils/extensions/toast_extension.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class LocationController extends GetxController {
  final LocationUtil _locationUtil;
  late final StreamSubscription<LocationData> _locationSubscription;
  RxString location = "".obs;
  RxBool isloading = false.obs;

  LocationController({required LocationUtil locationUtil})
    : _locationUtil = locationUtil;
  @override
  void onInit() {
    _locationSubscription = _locationUtil.onLocationChanged().listen((event) {
      fetchLocationFromLocationData(
        latitude: event.latitude,
        longitude: event.longitude,
      );
    });

    fetchLocation();
    super.onInit();
  }

  fetchLocation() async {
    try {

      bool res = await _locationUtil.checkLocationEnabled();
      if (res) {
        isloading.value=true;
        LocationData locationData = await _locationUtil.getPosition();
        await fetchLocationFromLocationData(
          latitude: locationData.latitude,
          longitude: locationData.longitude,
        );
        isloading.value=false;
      } else {
        var res = await _locationUtil.requestLocationService();
        if (!res) {
          Get.showToast("Location Fetch Failed!,Enable Location and try again");
        }
        else{
          fetchLocation();
        }
      }
    } catch (e) {
       isloading.value=false;
      Get.showToast("Location Fetch Failed");
    }
  }

  Future<void> fetchLocationFromLocationData({
    double? latitude,
    double? longitude,
  }) async {
    List<Placemark> placeMarks = await _locationUtil.getAddressFromPosition(
      latitude!,
      longitude!,
    );
    location.value = _locationUtil.formatPlacemark(placeMarks.first);
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    super.dispose();
  }
}
