import 'dart:async';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/user_location.dart';
import '../usecase/update_location.dart';

class LocationController extends GetxController {
  final UpdateLocationUseCase _updateLocationUseCase;
  final String userId = 'user1'; // Replace with dynamic user ID
  var markers = <Marker>{}.obs;
  Timer? locationUpdateTimer;

  LocationController(this._updateLocationUseCase);

  @override
  void onInit() {
    super.onInit();
    _requestLocationPermission();
    _startLocationUpdates();
    _listenToOtherUsers();
  }

  @override
  void onClose() {
    locationUpdateTimer?.cancel();
    super.onClose();
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var location = UserLocation(latitude: position.latitude, longitude: position.longitude);
    await _updateLocationUseCase.execute(userId, location);
  }

  void _startLocationUpdates() {
    locationUpdateTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      var location = UserLocation(latitude: position.latitude, longitude: position.longitude);
      await _updateLocationUseCase.execute(userId, location);
    });
  }

  void _listenToOtherUsers() {
    // Listen to other users' locations using repository's stream
  }
}
