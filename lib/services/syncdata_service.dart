import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../data/task_rules.dart';

class SyncService {
  /// [A] 계정 변경(로그인/로그아웃) 시: 로컬 초기화 + Firestore 데이터로 교체
  static Future<void> syncOnAccountChange() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('로그인 필요');
    final box = Hive.box<CropData>('crops');

    // 1. 로컬 데이터 모두 삭제
    await box.clear();

    // 2. Firestore에서 새 계정의 데이터만 로컬에 저장
    final cropsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('crops');
    final snapshot = await cropsRef.get();

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
      ));
    }
  }

  /// [B] 동기화 버튼 클릭 시: 로컬 → 클라우드 업로드, 다시 클라우드 → 로컬로 최신화
  static Future<void> syncWithCloud() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('로그인 필요');
    final box = Hive.box<CropData>('crops');

    // 1. Firestore 기존 데이터 삭제
    final cropsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('crops');
    final snapshot = await cropsRef.get();
    for (final doc in snapshot.docs) {
      try {
        await doc.reference.delete();
      } catch (_) {}
    }

    // 2. 로컬(Hive) 데이터 Firestore에 업로드
    final crops = box.values.toList();
    for (final crop in crops) {
      try {
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
        });
      } catch (_) {}
    }

    // 3. Firestore에서 다시 받아와 로컬(Hive) 최신화
    final newSnapshot = await cropsRef.get();
    await box.clear();
    for (final doc in newSnapshot.docs) {
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
      ));
    }
  }
}
