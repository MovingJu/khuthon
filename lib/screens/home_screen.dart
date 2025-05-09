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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SafeArea(
          // ✅ SafeArea로 상단 패딩 확보
          child: AppBar(
            title: const Text(
              '고민 제로 작물 플렛폼, 작물픽!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true, // ✅ 중앙 정렬
            toolbarHeight: 100,
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.green, width: 4),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 5), // ✅ 오른쪽 끝에서 5픽셀 띄우기
                child: IconButton(
                  icon: const Icon(Icons.account_circle),
                  iconSize: 50, // ✅ 아이콘 사이즈
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SettingsScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/logo.png', height: 200),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
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
