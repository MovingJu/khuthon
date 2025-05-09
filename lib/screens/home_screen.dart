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

  final List<Widget> _pages = [
    HomeTab(),
    InputScreen(qaPairs: []),
    ResultScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('고민 제로 작물 플렛폼, 작물픽!'),
        centerTitle: true,
        toolbarHeight: 100, // 💡 AppBar 높이 키움
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            iconSize: 40, // 💡 프로필 아이콘 키움
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      // 💡 전체를 화면 중앙에 정렬
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 💡 세로 중앙 정렬
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/logo.png', height: 150), // 💡 로고 조금 키움
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // 💡 버튼도 중앙으로
            children: [
              SizedBox(
                width: 150, // 버튼 가로 폭 고정 (적당히 예쁘게)
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SurveyScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(60),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green,
                  ),
                  child: const Text('작물 추천받기'),
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MyFarmScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(60),
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.lightGreenAccent,
                  ),
                  child: const Text('내 농장'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
