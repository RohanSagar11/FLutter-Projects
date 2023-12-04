import 'package:geolocator/geolocator.dart';

Future<Map<String, double>> getCurrentLocation() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double latitude = position.latitude;
    double longitude = position.longitude;

    return {'latitude': latitude, 'longitude': longitude};
  } catch (e) {
    throw Exception('Error getting location: $e');
  }
}
// This example shows how you can call the getCurrentLocation() function and access the latitude and longitude values using the geolocator package.





