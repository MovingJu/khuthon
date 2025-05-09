import 'package:flutter/material.dart';
import 'survey_screen.dart';
import 'input_screen.dart';
import 'result_screen.dart';
import 'settings_screen.dart';
import 'myfarm_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // 탭에 표시할 페이지 리스트
  final List<Widget> _pages = [
    HomeTab(),
    InputScreen(qaPairs: []),
    ResultScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('당신만을 위한 작물 플랫폼, 작물픽!'), centerTitle: true),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.input), label: '인풋'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bus_alert_outlined),
            label: '결과',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

/// Home 탭의 콘텐츠만 담당하는 위젯
class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/logo.png', height: 120),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SurveyScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(60),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green,
                  ),
                  child: Text('작물 추천받기'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MyFarmScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(60),
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.lightGreenAccent,
                  ),
                  child: Text('내 농장'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
