import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/seat.dart';
import '../services/firestore_service.dart';

final selectedBusIdProvider = StateProvider<String?>((ref) => null);

final seatsProvider = StreamProvider.autoDispose<List<Seat>>((ref) {
  final busId = ref.watch(selectedBusIdProvider).state;
  if (busId == null) return const Stream.empty();
  return ref.read(firestoreServiceProvider).getSeats(busId);
});

final bookingEnabledProvider = StreamProvider<bool>(
  (ref) => ref.read(firestoreServiceProvider).getBookingStatus(),
);
