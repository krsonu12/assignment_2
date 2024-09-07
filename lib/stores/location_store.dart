import 'dart:developer';

import 'package:customer_app/models/customer.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
part 'location_store.g.dart';

class LocationStore = LocationStoreBase with _$LocationStore;

abstract class LocationStoreBase with Store {
  @observable
  double? latitude;

  @observable
  double? longitude;

  @observable
  String? geoAddress;

  @action
  Future<void> getLocation() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      final position = await Geolocator.getCurrentPosition();
      final placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      latitude = position.latitude;
      longitude = position.longitude;
      geoAddress =
          '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.country}';
    }
  }

  @action
  Future<void> openGoogleMaps(Customer customer) async {
    try {
      Position currentPosition = await Geolocator.getCurrentPosition();

      final url = Uri.parse(
          'https://www.google.com/maps/dir/?api=1&origin=${currentPosition.latitude},${currentPosition.longitude}&destination=${customer.latitude},${customer.longitude}&travelmode=driving');

      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      log(
        e.toString(),
      );
    }
  }
}
