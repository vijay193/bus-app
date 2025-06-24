import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/bus_provider.dart';
import '../widgets/bus_card.dart';
import '../constants/app_routes.dart';

class BusListScreen extends ConsumerWidget {
  const BusListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busesAsync = ref.watch(busesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Buses')),
      body: busesAsync.when(
        data: (buses) => ListView.builder(
          itemCount: buses.length,
          itemBuilder: (context, index) {
            final bus = buses[index];
            return BusCard(
              bus: bus,
              onTap: () {
                ref.read(selectedBusIdProvider.notifier).state = bus.id;
                Navigator.pushNamed(context, AppRoutes.seatBooking);
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
