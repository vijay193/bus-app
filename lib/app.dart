import 'package:flutter/material.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/select_district_screen.dart';
import 'screens/bus_list_screen.dart';
import 'screens/seat_booking_screen.dart';
import 'screens/map_screen.dart';
import 'screens/upload_csv_screen.dart';
import 'screens/pdf_confirmation_screen.dart';
import 'constants/app_routes.dart';

class BusBookingApp extends StatelessWidget {
  const BusBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Booking App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      initialRoute: AppRoutes.signIn,
      routes: {
        AppRoutes.signIn: (_) => const SignInScreen(),
        AppRoutes.signUp: (_) => const SignUpScreen(),
        AppRoutes.selectDistrict: (_) => const SelectDistrictScreen(),
        AppRoutes.busList: (_) => const BusListScreen(),
        AppRoutes.seatBooking: (_) => const SeatBookingScreen(),
        AppRoutes.map: (_) => const MapScreen(),
        AppRoutes.uploadCsv: (_) => const UploadCsvScreen(),
        AppRoutes.pdfConfirmation: (_) => const PdfConfirmationScreen(
          userId: 'user123',
          seatId: 'A1',
          busName: 'Bus 001',
        ),
      },
    );
  }
}
