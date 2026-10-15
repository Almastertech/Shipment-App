import 'package:geolocator/geolocator.dart';

import 'location_coordinates.dart';
import 'location_service.dart';

class GeolocatorLocationService implements LocationService {
  const GeolocatorLocationService();

  @override
  Future<bool> isLocationServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<bool> openLocationSettings() {
    return Geolocator.openLocationSettings();
  }

  @override
  Future<LocationCoordinates> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    return LocationCoordinates(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}
