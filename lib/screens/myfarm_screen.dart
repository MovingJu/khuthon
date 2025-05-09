import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../services/syncdata_service.dart';
import '../data/task_rules.dart'; // CropData 정의된 곳
import 'package:url_launcher/url_launcher.dart';

/// 캘린더 이벤트 모델 (직렬화용 JSON)
class CalendarEvent {
  final String plantName;
  final EventType type;

  CalendarEvent(this.plantName, this.type);

  Map<String, dynamic> toJson() => {
        'plantName': plantName,
        'type': type.index,
      };

  static CalendarEvent fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      json['plantName'] as String,
      EventType.values[json['type'] as int],
    );
  }

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
  Box<List>? eventBox;

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    // 두 개의 Hive 박스 열기
    Hive.openBox<CropData>('crops').then((box) {
      setState(() => cropBox = box);
    });
    Hive.openBox<List>('events').then((box) {
      setState(() => eventBox = box);
    });
  }

  String _dateKey(DateTime day) =>
      '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    if (eventBox == null) return [];
    final key = _dateKey(day);
    final rawList = eventBox!.get(key, defaultValue: <dynamic>[])!;
    return rawList
        .cast<Map>()
        .map((m) => CalendarEvent.fromJson(Map<String, dynamic>.from(m)))
        .toList();
  }

  void _addEvent(String plantName, EventType type) {
    if (eventBox == null) return;
    final key = _dateKey(_selectedDay);
    final rawList = List<Map<String, dynamic>>.from(
        eventBox!.get(key, defaultValue: <dynamic>[])!);
    rawList.add(CalendarEvent(plantName, type).toJson());
    eventBox!.put(key, rawList);
    setState(() {}); // UI 갱신
  }

  void _deleteEvent(DateTime day, CalendarEvent event) {
  if (eventBox == null) return;
  final key = _dateKey(day);
  // 기존 리스트 가져오기
  final rawList = List<Map<String, dynamic>>.from(
    eventBox!.get(key, defaultValue: <dynamic>[])!
  );
  // 첫 번째로 일치하는 항목의 인덱스 찾기
  final idx = rawList.indexWhere((m) {
    final e = CalendarEvent.fromJson(Map<String, dynamic>.from(m));
    return e.plantName == event.plantName && e.type == event.type;
  });
  if (idx != -1) {
    rawList.removeAt(idx);               // 해당 인덱스 하나만 삭제
    if (rawList.isEmpty) {
      eventBox!.delete(key);             // 리스트가 비면 키 자체 삭제
    } else {
      eventBox!.put(key, rawList);       // 아니면 업데이트
    }
    setState(() {});                     // UI 갱신
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
    if (cropBox == null || eventBox == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text('내 농장'),
          actions: [
            IconButton(
            icon: const Icon(Icons.sync),
            tooltip: '동기화',
            onPressed: () async {
              try {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('동기화 중...')),
                );
                await SyncService.syncByTimestamp();
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('동기화 완료!')),
                );
                setState(() {}); // 동기화 후 UI 갱신
              } catch (e) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('동기화 실패: $e')),
                );
              }
            },
          ),
          ],
      ),
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
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        subtitle: Text('물 주기 팁: ${crop.waterperiod}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                            icon : Icon(Icons.shopping_cart),
                            tooltip: '구매 링크',
                            onPressed: () async {
                              final query = Uri.encodeComponent(crop.name);
                              final url = 'https://search.shopping.naver.com/ns/search?query=$query씨앗';
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url),mode: LaunchMode.inAppBrowserView);
                              } 
                              else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('링크를 열 수 없습니다.')),
                                  );
                              }
                            }
                          ),
                            IconButton(
                              icon: const Icon(Icons.opacity, color: Colors. blue,),
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
    final nameCtrl = TextEditingController();
    final waterCtrl = TextEditingController();
    final sunCtrl = TextEditingController();
    final descCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('새 작물 추가'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: '작물 이름'),
              ),
              TextField(
                controller: waterCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: '물 주기(일)'),
              ),
              TextField(
                controller: sunCtrl,
                decoration: const InputDecoration(labelText: '광량 필요도'),
              ),
              TextField(
                controller: descCtrl,
                decoration: const InputDecoration(labelText: '설명'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameCtrl.text.trim();
              final water = waterCtrl.text.trim();
              final sun  = sunCtrl.text.trim();
              final desc = descCtrl.text.trim();
              if (name.isNotEmpty) {
                final newCrop = CropData(
                  name: name,
                  waterperiod: water,
                  sunneed: sun,
                  description: desc,
                );
                cropBox!.add(newCrop);
              }
              Navigator.pop(ctx);
            },
            child: const Text('추가'),
          ),
        ],
      ),
    );
  },
  child: const Icon(Icons.add),
),
    );
  }
}

/// 연-월-일 비교 유틸
bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;