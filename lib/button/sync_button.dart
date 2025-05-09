import 'package:flutter/material.dart';
import '../services/syncdata_service.dart';

Widget syncButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () async {
      try {
        await SyncService.sync();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('동기화가 완료되었습니다!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('동기화 실패: $e')),
        );
      }
    },
    child: Text('동기화'),
  );
}