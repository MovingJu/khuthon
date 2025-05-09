import 'package:hive/hive.dart';
part 'task_rules.g.dart';

@HiveType(typeId: 0)
class CropData extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String waterperiod;

  @HiveField(2)
  String sunneed;

  @HiveField(3)
  String description;

  @HiveField(4)
  String? difficulty;

  @HiveField(5)
  String? info;

  @HiveField(6)
  String? indoorfriendly; //실내 적합성

  @HiveField(7)
  DateTime? sowingdate;

  @HiveField(8)
  DateTime? harvestdate;

  CropData({
    required this.name,
    required this.waterperiod,
    required this.sunneed,
    required this.description,
  });
}

class CropDataBase {
  static final Box<CropData> box = Hive.box<CropData>('crops');

  static Future<void> addCrop(CropData crop) async {
    await box.add(crop);
  }

  static List<CropData> getAllCrops() {
    return box.values.toList();
  }

  static Future<void> updateCrop(int index, CropData crop) async {
    await box.putAt(index, crop);
  }

  static Future<void> deleteCrop(int index) async {
    await box.deleteAt(index);
  }

  static CropData? getCropAt(int index) {
    return box.getAt(index);
  }

  static int getCropCount() {
    return box.length;
  }

  static Future<void> clearAll() async {
    await box.clear();
  }
}//