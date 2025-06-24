class Bus {
  final String id;
  final String name;
  final String district;
  final List<String> stops;
  final String schedule;
  final double latitude;
  final double longitude;

  Bus({
    required this.id,
    required this.name,
    required this.district,
    required this.stops,
    required this.schedule,
    required this.latitude,
    required this.longitude,
  });

  factory Bus.fromMap(Map<String, dynamic> data, String documentId) {
    return Bus(
      id: documentId,
      name: data['name'] ?? '',
      district: data['district'] ?? '',
      stops: List<String>.from(data['stops'] ?? []),
      schedule: data['schedule'] ?? '',
      latitude: data['latitude']?.toDouble() ?? 0.0,
      longitude: data['longitude']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'district': district,
      'stops': stops,
      'schedule': schedule,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
