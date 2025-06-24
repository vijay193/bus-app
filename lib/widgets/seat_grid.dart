import 'package:flutter/material.dart';
import '../models/seat.dart';

class SeatGrid extends StatelessWidget {
  final List<Seat> seats;

  const SeatGrid({super.key, required this.seats});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: seats.length,
      itemBuilder: (context, index) {
        final seat = seats[index];
        return Container(
          decoration: BoxDecoration(
            color: seat.isBooked ? Colors.red : Colors.green,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              seat.id,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
