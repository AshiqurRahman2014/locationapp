import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controller/location_controller.dart';
import '../usecase/update_location.dart';

class LocationSharingScreen extends StatelessWidget {
  final LocationController locationController = Get.put(LocationController(Get.find<UpdateLocationUseCase>()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real-Time Location Sharing'),
      ),
      body: Obx(() => GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), // San Francisco
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          // Do something with the map controller if needed
        },
        markers: locationController.markers.toSet(),
      )),
    );
  }
}
