import 'package:firebase_database/firebase_database.dart';

class GpsService {
  final _db = FirebaseDatabase.instance.reference();

  Future<void> updateLocation(String busId, double lat, double lng) async {
    await _db.child('locations/$busId').set({
      'latitude': lat,
      'longitude': lng,
    });
  }

  Stream<Map<String, dynamic>> getBusLocation(String busId) {
    return _db
        .child('locations/$busId')
        .onValue
        .map((event) => Map<String, dynamic>.from(event.snapshot.value as Map));
  }
}
