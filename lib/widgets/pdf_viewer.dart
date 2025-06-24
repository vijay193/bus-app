import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfViewer extends StatelessWidget {
  final pw.Document document;

  const PdfViewer({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Viewer')),
      body: PdfPreview(build: (format) => document.save()),
    );
  }
}
