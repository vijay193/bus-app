enum SeatType { window, aisle }

class Seat {
  final String id;
  final SeatType type;
  final bool isBooked;
  final String? bookedBy;

  Seat({
    required this.id,
    required this.type,
    this.isBooked = false,
    this.bookedBy,
  });

  factory Seat.fromMap(Map<String, dynamic> data, String seatId) {
    return Seat(
      id: seatId,
      type: data['type'] == 'window' ? SeatType.window : SeatType.aisle,
      isBooked: data['isBooked'] ?? false,
      bookedBy: data['bookedBy'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type == SeatType.window ? 'window' : 'aisle',
      'isBooked': isBooked,
      'bookedBy': bookedBy,
    };
  }
}
