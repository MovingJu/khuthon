import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../data/task_rules.dart';

class SyncService {
  /// [A] 로컬(Hive) → 클라우드(Firestore) 업로드: Firestore 컬렉션 전체 삭제 후 Hive 데이터만 업로드
  static Future<void> uploadHiveToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('로그인 필요');
    final box = Hive.box<CropData>('crops');
    final crops = box.values.toList();

    final cropsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('crops');

    // 1. Firestore 기존 데이터 전체 삭제
    final snapshot = await cropsRef.get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }

    // 2. Hive 데이터만 Firestore에 업로드
    for (final crop in crops) {
      await cropsRef.add({
        'name': crop.name,
        'waterperiod': crop.waterperiod,
        'sunneed': crop.sunneed,
        'description': crop.description,
        'difficulty': crop.difficulty,
        'info': crop.info,
        'indoorfriendly': crop.indoorfriendly,
        'sowingdate': crop.sowingdate,
        'harvestdate': crop.harvestdate,
        'updatedAt': crop.updatedAt ?? DateTime.now(),
      });
    }
  }

  /// [B] 클라우드(Firestore) → 로컬(Hive) 다운로드: Hive 전체 삭제 후 Firestore 데이터만 저장
  static Future<void> downloadFirestoreToHive() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('로그인 필요');
    final cropsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('crops');
    final snapshot = await cropsRef.get();

    final box = Hive.box<CropData>('crops');
    // 1. 로컬(Hive) 기존 데이터 전체 삭제
    await box.clear();

    // 2. Firestore 데이터만 Hive에 저장
    for (final doc in snapshot.docs) {
      final data = doc.data();
      await box.add(CropData(
        name: data['name'] ?? '',
        waterperiod: data['waterperiod'] ?? '',
        sunneed: data['sunneed'] ?? '',
        description: data['description'] ?? '',
        // difficulty: data['difficulty'],
        // info: data['info'],
        // indoorfriendly: data['indoorfriendly'],
        // sowingdate: data['sowingdate'] is Timestamp
        //     ? (data['sowingdate'] as Timestamp).toDate()
        //     : data['sowingdate'] is DateTime
        //     ? data['sowingdate'] as DateTime
        //     : null,
        // harvestdate: data['harvestdate'] is Timestamp
        //     ? (data['harvestdate'] as Timestamp).toDate()
        //     : data['harvestdate'] is DateTime
        //     ? data['harvestdate'] as DateTime
        //     : null,
        // updatedAt: data['updatedAt'] is Timestamp
        //     ? (data['updatedAt'] as Timestamp).toDate()
        //     : data['updatedAt'] is DateTime
        //     ? data['updatedAt'] as DateTime
        //     : null,
      ));
    }
  }

  /// [C] 동기화: 업로드 → 다운로드 순으로 실행 (삭제까지 항상 반영)
  static Future<void> syncWithOverwrite() async {
    await uploadHiveToFirestore();
    await downloadFirestoreToHive();
  }
}
