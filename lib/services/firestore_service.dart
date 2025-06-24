import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/bus.dart';
import '../models/seat.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Bus>> getBusesByDistrict(String district) {
    return _db
        .collection('buses')
        .where('district', isEqualTo: district)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Bus.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  Stream<List<Seat>> getSeats(String busId) {
    return _db
        .collection('buses')
        .doc(busId)
        .collection('seats')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Seat.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  Future<void> bookSeat(String busId, String seatId, String userId) async {
    final seatRef = _db
        .collection('buses')
        .doc(busId)
        .collection('seats')
        .doc(seatId);
    await seatRef.update({'isBooked': true, 'bookedBy': userId});
  }

  Future<void> unbookSeat(String busId, String seatId) async {
    final seatRef = _db
        .collection('buses')
        .doc(busId)
        .collection('seats')
        .doc(seatId);
    await seatRef.update({'isBooked': false, 'bookedBy': null});
  }

  Stream<bool> getBookingStatus() {
    return _db
        .collection('settings')
        .doc('booking')
        .snapshots()
        .map((snap) => snap.data()?['enabled'] ?? true);
  }

  Future<void> toggleBooking(bool enabled) {
    return _db.collection('settings').doc('booking').set({'enabled': enabled});
  }
}
