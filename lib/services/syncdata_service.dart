// lib/services/sync_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../data/task_rules.dart'; // CropData 모델 import

class SyncService {
  /// 계정 변경 시: 기존 로컬 데이터 삭제 + 새 계정 Firestore 데이터로 동기화
  static Future<void> syncOnAccountChange() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('로그인 필요');

    final box = Hive.box<CropData>('crops');

    // 1. 기존 로컬 데이터 모두 삭제
    print('로컬(Hive) 데이터 삭제 시작');
    await box.clear();
    print('로컬(Hive) 데이터 삭제 완료');

    // 2. Firestore에서 새 계정의 작물 데이터 다운로드
    final cropsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('crops');
    final snapshot = await cropsRef.get();
    print('Firestore에서 받아온 문서 개수: ${snapshot.docs.length}');

    // 3. Firestore 데이터 Hive에 저장
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
    print('새 계정의 Firestore 데이터로 로컬 동기화 완료');
  }
}
