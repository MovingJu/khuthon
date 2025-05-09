import 'package:flutter/material.dart';
import '../services/crop_parser.dart';
import '../models/crop.dart';

class SettingsScreen extends StatefulWidget {
  final String result;

  const SettingsScreen({
    super.key,
    this.result = '', // ✅ 기본값 추가
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<Crop> _crops = [];

  @override
  void initState() {
    super.initState();
    _parseResult();
  }

  void _parseResult() {
    try {
      final crops = parseGptResponse(widget.result);
      setState(() {
        _crops = crops;
      });
    } catch (e) {
      setState(() {
        _crops = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('추천 결과')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            _crops.isEmpty
                ? const Text('추천 결과를 표시할 수 없습니다.')
                : ListView.builder(
                  itemCount: _crops.length,
                  itemBuilder: (context, index) {
                  },
                ),
      ),
    );
  }
}
