import 'location_coordinates.dart';

abstract class LocationService {
  Future<bool> isLocationServiceEnabled();

  Future<bool> openLocationSettings();

  Future<LocationCoordinates> getCurrentLocation();
}
