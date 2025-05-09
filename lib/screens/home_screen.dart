import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ✅ 추가
import 'tutorial_screen.dart'; // ✅ 튜토리얼 스크린 불러오기 (아래 예제에 만들어 둘게)
import 'input_screen.dart';
import 'result_screen.dart';

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeTab(),
    InputScreen(qaPairs: []),
    ResultScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch(); // ✅ 최초 실행 체크
  }

  Future<void> _checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLaunch = prefs.getBool('isFirstLaunch');

    if (isFirstLaunch == null || isFirstLaunch) {
      // ✅ 튜토리얼 띄우기
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TutorialScreen()),
        );
      });

      // ✅ 최초 실행 끝났으니 기록 남기기
      await prefs.setBool('isFirstLaunch', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SafeArea(
          child: AppBar(
            title: const Text(
              '고민 제로 작물 플렛폼, 작물픽!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
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
                padding: const EdgeInsets.only(right: 5),
                child: IconButton(
                  icon: const Icon(Icons.account_circle),
                  iconSize: 50,
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
