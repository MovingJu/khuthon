import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../models/crop_data.dart'; // CropData 모델 import

class SyncService {
  /// Hive → Firestore로 업로드 (로컬 데이터를 클라우드에 저장)
  static Future<void> uploadHiveToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('로그인 필요');

    final box = await Hive.openBox<CropData>('crops');
    final crops = box.values.toList();

    final cropsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('crops');

    // Firestore의 기존 데이터 삭제 (필요시)
    final snapshot = await cropsRef.get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }

    // Hive의 모든 데이터를 Firestore에 업로드
    for (final crop in crops) {
      await cropsRef.add({
        'name': crop.name,
        'waterperiod': crop.waterperiod,
        'sunneed': crop.sunneed,
        'description': crop.description,
      });
    }
  }

  /// Firestore → Hive로 동기화 (클라우드 데이터를 로컬에 저장)
  static Future<void> downloadFirestoreToHive() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('로그인 필요');

    final cropsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('crops');
    final snapshot = await cropsRef.get();

    final box = await Hive.openBox<CropData>('crops');
    await box.clear(); // 기존 로컬 데이터 삭제

    for (final doc in snapshot.docs) {
      final data = doc.data();
      await box.add(CropData(
        name: data['name'] ?? '',
        waterperiod: data['waterperiod'] ?? '',
        sunneed: data['sunneed'] ?? '',
        description: data['description'] ?? '',
      ));
    }
  }

  /// 동기화: 로컬(Hive) → 클라우드(Firestore) → 로컬(Hive) 순서로 갱신
  static Future<void> sync() async {
    await uploadHiveToFirestore();
    await downloadFirestoreToHive();
  }
}
