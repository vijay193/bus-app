import 'package:flutter/material.dart';
import '../models/bus.dart';

class BusCard extends StatelessWidget {
  final Bus bus;
  final VoidCallback onTap;

  const BusCard({super.key, required this.bus, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(bus.name),
        subtitle: Text('${bus.route} • ${bus.schedule}'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}
