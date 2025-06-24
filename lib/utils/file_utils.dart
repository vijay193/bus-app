import 'dart:convert';
import 'dart:typed_data';
import 'package:csv/csv.dart';

class FileUtils {
  static List<List<dynamic>> parseCsv(Uint8List bytes) {
    final csvString = utf8.decode(bytes);
    return const CsvToListConverter().convert(csvString);
  }
}
