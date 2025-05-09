import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/crop.dart';
import '../services/crop_parser.dart';
import '../data/task_rules.dart';

class ResultScreen extends StatefulWidget {
  final String result;
  const ResultScreen({super.key, this.result = ''});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<Crop> _crops = [];
  int? _selectedIndex;

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

  Future<void> _addToFarm() async {
    if (_selectedIndex == null) return;
    final selectedCrop = _crops[_selectedIndex!];
    final box = await Hive.openBox<CropData>('crops');
    await box.add(CropData(
      name: selectedCrop.name,
      waterperiod: selectedCrop.waterCycle,
      sunneed: selectedCrop.lightNeeds,
      description: selectedCrop.description,
    ));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${selectedCrop.name}이(가) 내 농장에 추가되었습니다!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('추천 결과'),
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green, // 원하는 배경색
              foregroundColor: Colors.white, // 텍스트/아이콘 색
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onPressed: _selectedIndex == null ? null : _addToFarm,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text('내 농장 추가', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _crops.isEmpty
            ? const Text('추천 결과를 표시할 수 없습니다.')
            : ListView.builder(
          itemCount: _crops.length,
          itemBuilder: (context, index) {
            final crop = _crops[index];
            return Card(
              color: _selectedIndex == index ? Colors.green[100] : null,
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
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                selected: _selectedIndex == index,
              ),
            );
          },
        ),
      ),
    );
  }
}
