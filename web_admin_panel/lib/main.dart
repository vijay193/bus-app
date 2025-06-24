// web_admin_panel/lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const WebAdminApp());
}

class WebAdminApp extends StatelessWidget {
  const WebAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Admin Panel',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  bool bookingEnabled = true;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('config')
        .doc('settings')
        .snapshots()
        .listen((doc) {
      setState(() {
        bookingEnabled = doc['bookingEnabled'] ?? true;
      });
    });
  }

  void toggleBooking(bool value) async {
    await FirebaseFirestore.instance
        .collection('config')
        .doc('settings')
        .set({'bookingEnabled': value}, SetOptions(merge: true));
  }

  Future<Uint8List> generatePdf(
      String userId, String seatId, String busName) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Bus Booking Confirmation',
                  style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              pw.Text('User ID: $userId'),
              pw.Text('Seat ID: $seatId'),
              pw.Text('Bus: $busName'),
              pw.Text('Date: ${DateTime.now()}'),
            ],
          ),
        ),
      ),
    );

    return pdf.save();
  }

  void showPdfPreview(String userId, String seatId, String busName) async {
    final pdfData = await generatePdf(userId, seatId, busName);
    await Printing.layoutPdf(onLayout: (_) async => pdfData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Enable Bookings', style: TextStyle(fontSize: 18)),
                Switch(
                  value: bookingEnabled,
                  onChanged: toggleBooking,
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => showPdfPreview('user123', 'S15', 'Bus 42'),
              child: const Text('Generate Sample PDF'),
            ),
            const SizedBox(height: 20),
            const Text('Registered Users',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final users = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        title: Text(user['email'] ?? 'No email'),
                        subtitle: Text(user.id),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
