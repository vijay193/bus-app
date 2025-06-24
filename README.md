# Web Admin Panel for Bus Booking App

## ✅ Overview
A Flutter Web Admin dashboard for managing bus schedules, enabling/disabling bookings, viewing registered users, and generating PDF confirmations.

## 🛠 Features
- Booking ON/OFF toggle (via Firestore)
- Live user list stream
- PDF receipt generation (sample)

## 🚀 Getting Started

### 1. Prerequisites
- Flutter SDK (>=3.10)
- Firebase project set up with:
  - Firestore
  - Firebase Web App Config

### 2. Clone & Install Dependencies
```bash
git clone <your-repo-url>
cd web_admin_panel
flutter pub get
```

### 3. Firebase Configuration
Replace your web `firebaseOptions` (from Firebase Console) in `main.dart` if needed:
```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```
Or use `firebase_options.dart` via `flutterfire configure`

### 4. Run Locally
```bash
flutter run -d chrome
```

### 5. Deploy to Web (optional)
```bash
flutter build web
```
Host with Firebase Hosting or any static site service.

## 🔐 Firestore Collections Used
- `config/settings` → `{ bookingEnabled: true }`
- `users/` → each user doc with `email`

## 🧾 PDF Feature
A sample PDF generator is included. Integrate with real booking data for production.

## 📦 Dependencies
- `firebase_core`
- `cloud_firestore`
- `pdf`
- `printing`

## 📁 Folder Structure
```
📁 /bus_booking_app/
├── android/
├── ios/
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── models/
│   │   ├── bus.dart
│   │   ├── seat.dart
│   ├── services/
│   │   ├── auth_service.dart
│   │   ├── gps_service.dart
│   │   ├── firestore_service.dart
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   ├── bus_provider.dart
│   │   ├── seat_provider.dart
│   ├── screens/
│   │   ├── sign_in_screen.dart
│   │   ├── sign_up_screen.dart
│   │   ├── select_district_screen.dart
│   │   ├── bus_list_screen.dart
│   │   ├── seat_booking_screen.dart
│   │   ├── map_screen.dart
│   │   ├── upload_csv_screen.dart
│   │   ├── pdf_confirmation_screen.dart
│   ├── widgets/
│   │   ├── seat_grid.dart
│   │   ├── bus_card.dart
│   │   ├── auth_form.dart
│   │   ├── pdf_viewer.dart
│   ├── constants/
│   │   ├── app_styles.dart
│   │   ├── app_routes.dart
│   ├── utils/
│   │   ├── file_utils.dart
│   │   ├── map_utils.dart
├── functions/
│   ├── index.js        # Cloud Functions (Node.js for CSV/PDF parsing)
│   ├── package.json
├── web_admin_panel/    # (Optional: Flutter Web dashboard)
├── pubspec.yaml
├── README.md

```

## 🔒 Firestore Rules Example
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /config/{doc} {
      allow read, write: if request.auth.token.admin == true;
    }
    match /users/{userId} {
      allow read: if request.auth != null;
    }
  }
}
```

---

For full integration with the mobile booking app, connect this panel to the same Firebase backend.
