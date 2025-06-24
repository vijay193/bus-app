import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/gps_service.dart';
import '../providers/seat_provider.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  GoogleMapController? _mapController;
  LatLng _initialPosition = const LatLng(37.7749, -122.4194);
  Marker? _busMarker;

  @override
  void initState() {
    super.initState();
    final busId = ref.read(selectedBusIdProvider).state;
    if (busId != null) {
      ref.read(GpsService()).getBusLocation(busId).listen((location) {
        final lat = location['latitude'];
        final lng = location['longitude'];
        final pos = LatLng(lat, lng);
        setState(() {
          _busMarker = Marker(
            markerId: const MarkerId('bus'),
            position: pos,
            infoWindow: const InfoWindow(title: 'Bus Location'),
          );
        });
        _mapController?.animateCamera(CameraUpdate.newLatLng(pos));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Bus Map')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 10,
        ),
        onMapCreated: (controller) => _mapController = controller,
        markers: _busMarker != null ? {_busMarker!} : {},
      ),
    );
  }
}
