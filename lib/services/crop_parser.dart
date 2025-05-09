import 'dart:convert';
import '../models/crop.dart';
import '../data/task_rules.dart';
import 'package:hive/hive.dart';

List<Crop> parseGptResponse(String response) {
  final List<dynamic> jsonList = json.decode(response);
  return jsonList.map((item) {
    return Crop(
      name: item['name'] ?? '',
      waterCycle: item['waterCycle'] ?? '',
      lightNeeds: item['lightNeeds'] ?? '',
      description: item['description'] ?? '',
    );
  }).toList();
}

Future<void> parseGptResponseAndSave(String response) async {
  final List<dynamic> jsonList = json.decode(response);
  final List<CropData> crops=jsonList.map((item) {
    return CropData(
      name: item['name'] ?? '',
      waterperiod: item['waterCycle'] ?? '',
      sunneed: item['lightNeeds'] ?? '',
      description: item['description'] ?? '',
    );
  }).toList();


  final box = await Hive.openBox<CropData>('crops');
  // Hive에 저장
  for (var crop in crops) {
    await box.add(crop);
  }
}