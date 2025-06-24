import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfConfirmationScreen extends StatelessWidget {
  final String userId;
  final String seatId;
  final String busName;

  const PdfConfirmationScreen({
    super.key,
    required this.userId,
    required this.seatId,
    required this.busName,
  });

  @override
  Widget build(BuildContext context) {
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text(
            'Booking Confirmation\n\nUser: $userId\nBus: $busName\nSeat: $seatId',
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('PDF Receipt')),
      body: PdfPreview(
        build: (format) => doc.save(),
        allowPrinting: true,
        allowSharing: true,
        canChangePageFormat: false,
      ),
    );
  }
}
