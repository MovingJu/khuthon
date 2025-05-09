import 'dart:convert';
import '../models/crop.dart';

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
