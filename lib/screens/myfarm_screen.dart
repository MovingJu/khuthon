import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/task_rules.dart'; // CropData 정의된 곳

/// 캘린더 이벤트 모델
class CalendarEvent {
  final String plantName;
  final EventType type;

  CalendarEvent(this.plantName, this.type);

  @override
  String toString() {
    switch (type) {
      case EventType.add:
        return '🆕 작물 추가: $plantName';
      case EventType.water:
        return '💧 물주기: $plantName';
      case EventType.harvest:
        return '🌾 수확: $plantName';
    }
  }
}

enum EventType { add, water, harvest }

class MyFarmScreen extends StatefulWidget {
  const MyFarmScreen({Key? key}) : super(key: key);

  @override
  _MyFarmScreenState createState() => _MyFarmScreenState();
}

class _MyFarmScreenState extends State<MyFarmScreen> {
  Box<CropData>? cropBox;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  final Map<DateTime, List<CalendarEvent>> _events = {};

  @override
  void initState() {
    super.initState();
    Hive.openBox<CropData>('crops').then((box) {
      setState(() => cropBox = box);
    });
  }

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    final key = DateTime(day.year, day.month, day.day);
    return _events[key] ?? [];
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
        if (list.isEmpty) _events.remove(key);
      });
    }
  }

  Widget _buildEventList() {
    final dayEvents = _getEventsForDay(_selectedDay);
    if (dayEvents.isEmpty) {
      return const Center(child: Text('선택된 날짜에 기록된 이벤트가 없습니다.'));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: dayEvents.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (ctx, idx) {
        final e = dayEvents[idx];
        return ListTile(
          title: Text(e.toString()),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            onPressed: () => _deleteEvent(_selectedDay, e),
          ),
        );
      },
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
          // 1) 달력
          TableCalendar<CalendarEvent>(
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            focusedDay: _focusedDay,
            selectedDayPredicate: (d) => isSameDay(d, _selectedDay),
            eventLoader: _getEventsForDay,
            onDaySelected: (sel, foc) => setState(() {
              _selectedDay = sel;
              _focusedDay = foc;
            }),
          ),

          const Divider(height: 1),

          // 2) 선택된 날짜 이벤트 리스트
          Expanded(
            flex: 2,
            child: _buildEventList(),
          ),

          const Divider(height: 1),

          // 3) 작물별 물주기·수확·삭제 버튼
          Expanded(
            flex: 3,
            child: ValueListenableBuilder<Box<CropData>>(
              valueListenable: cropBox!.listenable(),
              builder: (context, box, _) {
                final crops = box.values.toList();
                if (crops.isEmpty) {
                  return const Center(child: Text('아직 내 농장에 작물이 없습니다!'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: crops.length,
                  itemBuilder: (ctx, i) {
                    final crop = crops[i];
                    return Card(
                      color: Colors.lightGreen,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        title: Text(
                          crop.name,
                          style: const TextStyle(fontSize: 18, color: Colors.black,),
                        ),
                        subtitle: Text('물 주기: ${crop.waterperiod}일 후'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.opacity, color: Colors. blueAccent,),
                              tooltip: '물주기 기록',
                              onPressed: () => _addEvent(crop.name, EventType.water),
                            ),
                            IconButton(
                              icon: const Icon(Icons.grass, color: Colors.greenAccent,),
                              tooltip: '수확 기록',
                              onPressed: () => _addEvent(crop.name, EventType.harvest),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              tooltip: '작물 삭제',
                              color: Colors.redAccent,
                              onPressed: () {
                                // 확인 다이얼로그 후 삭제
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text('${crop.name} 을(를) 삭제할까요?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('취소'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          box.deleteAt(i);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('삭제', style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        onLongPress: () {
                          // 롱프레스 시 해당 날짜 이벤트 삭제
                          final todayEvents = _getEventsForDay(_selectedDay);
                          CalendarEvent? target;
                          for (var ev in todayEvents) {
                            if (ev.plantName == crop.name) {
                              target = ev;
                              break;
                            }
                          }
                          if (target != null) {
                            _deleteEvent(_selectedDay, target);
                          }
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 새 작물 추가 화면으로 네비게이션
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// 연-월-일 비교 유틸
bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;
