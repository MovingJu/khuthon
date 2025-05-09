import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/task_rules.dart'; // For CropData

/// 캘린더의 이벤트를 표현할 모델
class CalendarEvent {
  final String plantName;
  final EventType type;

  CalendarEvent(this.plantName, this.type);

  @override
  String toString() =>
      type == EventType.add ? '🆕 작물 추가: $plantName' : '💧 물주기: $plantName';
}

enum EventType { add, water }

class MyFarmScreen extends StatefulWidget {
  const MyFarmScreen({Key? key}) : super(key: key);

  @override
  _MyFarmScreenState createState() => _MyFarmScreenState();
}

class _MyFarmScreenState extends State<MyFarmScreen> {
  Box<CropData>? cropBox;

  // 캘린더 관련 상태
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  final Map<DateTime, List<CalendarEvent>> _events = {};

  @override
  void initState() {
    super.initState();
    _openCropBox();
  }

  Future<void> _openCropBox() async {
    cropBox = await Hive.openBox<CropData>('crops');
    setState(() {});
  }

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  void _addEvent(String plantName, EventType type) {
    final key = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    final list = _events[key] ?? <CalendarEvent>[];
    list.add(CalendarEvent(plantName, type));
    setState(() {
      _events[key] = list;
    });
  }

  void _deleteEvent(DateTime day, CalendarEvent event) {
    final key = DateTime(day.year, day.month, day.day);
    final list = _events[key];
    if (list != null) {
      setState(() {
        list.remove(event);
        if (list.isEmpty) {
          _events.remove(key);
        }
      });
    }
  }

  void _showEventDialog(EventType type) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(type == EventType.add ? '작물 추가 기록' : '물주기 기록'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: '식물 이름을 입력하세요'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                _addEvent(name, type);
                Navigator.pop(context);
              }
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (cropBox == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('내 농장')),
      body: Column(
        children: [
          // 달력 + 이벤트 마커
          TableCalendar<CalendarEvent>(
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            eventLoader: _getEventsForDay,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: const CalendarStyle(
              markerSize: 6,
              markersMaxCount: 3,
            ),
          ),

          // 이벤트 등록 버튼
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _showEventDialog(EventType.add),
                  child: const Text('작물 추가 기록'),
                ),
                ElevatedButton(
                  onPressed: () => _showEventDialog(EventType.water),
                  child: const Text('물주기 기록'),
                ),
              ],
            ),
          ),

          // 선택한 날짜의 이벤트 리스트
          Expanded(
            child: ValueListenableBuilder<Box<CropData>>(
              valueListenable: cropBox!.listenable(),
              builder: (context, box, _) {
                final crops = box.values.toList();
                if (crops.isEmpty) {
                  return const Center(child: Text('아직 내 농장에 작물이 없습니다!'));
                }

                final dayKey = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
                final dayEvents = _getEventsForDay(_selectedDay);

                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    if (dayEvents.isNotEmpty) ...[
                      const Text('선택된 날짜 이벤트:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      ...dayEvents.map((e) => ListTile(
                            title: Text(e.toString()),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () => _deleteEvent(_selectedDay, e),
                            ),
                          )),
                      const Divider(),
                    ],
                    const Text('내 농장 작물 리스트:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    ...crops.asMap().entries.map((entry) {
                      final index = entry.key;
                      final crop = entry.value;
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text(crop.name),
                          subtitle: Text('Water Cycle: ${crop.waterperiod}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => box.deleteAt(index),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to add new crop screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// 연-월-일 비교
bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;
