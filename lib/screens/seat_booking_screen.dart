import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/seat_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/seat_grid.dart';
import '../services/firestore_service.dart';

class SeatBookingScreen extends ConsumerWidget {
  const SeatBookingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seatsAsync = ref.watch(seatsProvider);
    final busId = ref.watch(selectedBusIdProvider).state;
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Book a Seat')),
      body: seatsAsync.when(
        data: (seats) => Column(
          children: [
            Expanded(child: SeatGrid(seats: seats)),
            ElevatedButton(
              onPressed: () async {
                final seatToBook = seats.firstWhere((s) => !s.isBooked);
                await ref
                    .read(firestoreServiceProvider)
                    .bookSeat(busId!, seatToBook.id, user!.uid);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Seat booked!')));
              },
              child: const Text('Book First Available Seat'),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
