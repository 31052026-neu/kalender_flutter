import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class JsonStorageService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/ereignisse.json');
  }

  Future<void> writeJsonData(Map<String, dynamic> data) async {
    final file = await _localFile;

    String jsonString = jsonEncode(data);

    await file.writeAsString(jsonString);
  }

  Future<Map<String, dynamic>> readJsonData() async {
    try {
      final file = await _localFile;

      if (!await file.exists()) {
        return {}; // Return empty map if no file exists yet
      }

      // Read contents as string
      String contents = await file.readAsString();

      // Decode the string back into a Dart Map
      return jsonDecode(contents) as Map<String, dynamic>;
    } catch (e) {
      // Handle or log error appropriately
      print("Error reading JSON file: $e");
      return {};
    }
  }
}
