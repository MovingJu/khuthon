import 'package:flutter/material.dart';
import '../services/crop_parser.dart';
import '../models/crop.dart';

class ResultScreen extends StatefulWidget {
  final String result;

  const ResultScreen({
    super.key,
    this.result = '', // ✅ 기본값 추가
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
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
                final crop = _crops[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(crop.name, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('물주기: ${crop.waterCycle}'),
                        Text('햇빛: ${crop.lightNeeds}'),
                        Text('설명: ${crop.description}'),
                      ],
                    ),
                  ),
                );
              },
            )
      ),
    );
  }
}
