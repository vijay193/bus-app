import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/bus_provider.dart';
import '../constants/app_routes.dart';

class SelectDistrictScreen extends ConsumerWidget {
  const SelectDistrictScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select District')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('District A'),
            onTap: () {
              ref.read(districtProvider.notifier).state = 'District A';
              Navigator.pushNamed(context, AppRoutes.busList);
            },
          ),
          ListTile(
            title: const Text('District B'),
            onTap: () {
              ref.read(districtProvider.notifier).state = 'District B';
              Navigator.pushNamed(context, AppRoutes.busList);
            },
          ),
        ],
      ),
    );
  }
}
