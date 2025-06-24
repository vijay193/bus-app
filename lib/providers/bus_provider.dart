import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bus.dart';
import '../services/firestore_service.dart';

final firestoreServiceProvider = Provider<FirestoreService>(
  (ref) => FirestoreService(),
);

final districtProvider = StateProvider<String?>((ref) => null);

final busesProvider = StreamProvider.autoDispose<List<Bus>>((ref) {
  final district = ref.watch(districtProvider).state;
  if (district == null) return const Stream.empty();
  return ref.read(firestoreServiceProvider).getBusesByDistrict(district);
});
