import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadCsvScreen extends StatefulWidget {
  const UploadCsvScreen({super.key});

  @override
  State<UploadCsvScreen> createState() => _UploadCsvScreenState();
}

class _UploadCsvScreenState extends State<UploadCsvScreen> {
  String status = 'Waiting...';

  Future<void> _uploadCsv() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (result != null && result.files.single.path != null) {
      final file = result.files.single;
      final ref = FirebaseStorage.instance.ref().child(
        'schedules/${file.name}',
      );
      await ref.putData(file.bytes!);
      setState(() => status = 'Uploaded: ${file.name}');
    } else {
      setState(() => status = 'Upload canceled');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Schedule CSV')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(status),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadCsv,
              child: const Text('Select CSV'),
            ),
          ],
        ),
      ),
    );
  }
}
