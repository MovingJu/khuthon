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
  bool _showTutorial = true; // 튜토리얼 오버레이 표시 여부

  final List<Widget> _pages = [
    const HomeTab(),
    InputScreen(qaPairs: []),
    const ResultScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ AppBar를 둥글게 & 테두리 & 마진 적용 + 위쪽 띄우기
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          margin: const EdgeInsets.fromLTRB(10, 34, 10, 10), // 위쪽 20픽셀 띄우기
          decoration: BoxDecoration(
            color: Colors.green, // AppBar 배경색
            borderRadius: BorderRadius.circular(20), // 둥근 모서리
            border: Border.all(
              color: Colors.lightGreenAccent, // 테두리 색상
              width: 3,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center, // ✅ 수직 중앙 정렬
            children: [
              const Expanded(
                child: Center(
                  child: Text(
                    '고민 제로 작물 플랫폼, 작물픽!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5), // 👉 오른쪽에서 5픽셀 띄우기
                child: IconButton(
                  icon: const Icon(Icons.account_circle),
                  color: Colors.white,
                  iconSize: 40,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          _pages[_selectedIndex],

          // ✅ 튜토리얼 오버레이
          if (_showTutorial)
            Container(
              color: Colors.black.withOpacity(0.6),
              child: Stack(
                children: [
                  // 👇 작물 추천받기 버튼 설명 (위쪽)
                  Positioned(
                    bottom: 280, // 버튼 위쪽에 위치
                    left: MediaQuery.of(context).size.width / 2.3 - 160,
                    child: Column(
                      children: const [
                        Text(
                          '여기를 눌러서\n작물 추천을 받아보세요!\n👇',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  // 👇 내 농장 버튼 설명 (아래쪽)
                  Positioned(
                    bottom: 140, // 버튼 아래쪽에 위치
                    right: MediaQuery.of(context).size.width / 2.2 - 160,
                    child: Column(
                      children: const [
                        Text(
                          '👆 여기는 내 농장!\n작물을 관리할 수 있어요!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  // 👇 닫기 버튼
                  Positioned(
                    top: 50,
                    right: 20,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _showTutorial = false;
                        });
                      },
                      child: const Text('닫기'),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      // 💡 전체를 화면 중앙에 정렬
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 세로 중앙 정렬
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/logo.png', height: 150), // 로고 조금 키움
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // 버튼도 중앙으로
            children: [
              SizedBox(
                width: 150, // 버튼 가로 폭 고정
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SurveyScreen()),
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
                      MaterialPageRoute(builder: (_) => const MyFarmScreen()),
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
