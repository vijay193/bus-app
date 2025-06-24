import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUtils {
  static Marker createMarker(String id, LatLng position, String title) {
    return Marker(
      markerId: MarkerId(id),
      position: position,
      infoWindow: InfoWindow(title: title),
    );
  }
}
