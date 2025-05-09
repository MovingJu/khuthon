import 'package:flutter/material.dart';
import 'package:khuthon/screens/input_screen.dart';
import 'result_screen.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  // 1. 질문 세트 정의
  final List<Map<String, dynamic>> proQuestions = [
    {
      'question': '현재 경작 중인 농지의 규모는?',
      'type': 'choice',
      'choices': ['소규모', '중규모', '대규모'],
    },
    {
      'question': '작물 재배의 주요 목적은?',
      'type': 'choice',
      'choices': ['판매/수익', '자가 소비', '연구/시험'],
    },
    {
      'question': '선호하는 재배 방식은?',
      'type': 'choice',
      'choices': ['노지', '시설(비닐하우스)', '스마트팜'],
    },
    {
      'question': '신기술(스마트팜 등)에 관심이 있으신가요?',
      'type': 'bool',
    },
  ];

  final List<Map<String, dynamic>> nonProQuestions = [
    {
      'question': '작물 재배의 목적은?',
      'type': 'choice',
      'choices': ['자급자족', '관상/취미', '가족 체험'],
    },
    {
      'question': '하루 관리 가능 시간은?',
      'type': 'choice',
      'choices': ['1시간 미만', '1~3시간', '3시간 이상'],
    },
    {
      'question': '재배 공간은?',
      'type': 'choice',
      'choices': ['베란다/실내', '마당', '작은 텃밭', '옥상'],
    },
    {
      'question': '작물 재배 경험이 있으신가요?',
      'type': 'choice',
      'choices': ['전혀 없음', '조금 있음', '경험 많음'],
    },
  ];

  // 2. 상태 변수
  bool? isProFarmer;
  int currentIndex = 0;

  // 질문-답변 쌍 리스트
  List<Map<String, dynamic>> qaPairs = [];

  List<Map<String, dynamic>> get currentQuestions {
    if (isProFarmer == null) return [];
    return isProFarmer! ? proQuestions : nonProQuestions;
  }

  void _next(dynamic answer) {
    setState(() {
      // 질문-답변 쌍 저장
      qaPairs.add({
        'question': currentQuestions[currentIndex]['question'],
        'answer': answer,
      });
      if (currentIndex < currentQuestions.length - 1) {
        currentIndex++;
      } else {
        // 결과 화면으로 질문-답변 쌍 리스트 전달
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => InputScreen(qaPairs: qaPairs),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1번 질문: 전문 농업인 여부
    if (isProFarmer == null) {
      return Scaffold(
        appBar: AppBar(title: Text('작물 추천 설문')),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('당신은 전문 농업인입니까?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => setState(() {
                  isProFarmer = true;
                  currentIndex = 0;
                  qaPairs.clear();
                }),
                child: Text('예'),
              ),
              ElevatedButton(
                onPressed: () => setState(() {
                  isProFarmer = false;
                  currentIndex = 0;
                  qaPairs.clear();
                }),
                child: Text('아니오'),
              ),
            ],
          ),
        ),
      );
    }

    // 그 외 질문
    final q = currentQuestions[currentIndex];
    return Scaffold(
      appBar: AppBar(title: Text('작물 추천 설문')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              q['question'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            if (q['type'] == 'bool') ...[
              ElevatedButton(
                onPressed: () => _next(true),
                child: Text('예'),
              ),
              ElevatedButton(
                onPressed: () => _next(false),
                child: Text('아니오'),
              ),
            ] else if (q['type'] == 'choice') ...[
              ...(q['choices'] as List<String>).map((choice) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ElevatedButton(
                  onPressed: () => _next(choice),
                  child: Text(choice),
                ),
              )),
            ],
            Spacer(),
            Text(
              '질문 ${currentIndex + 1} / ${currentQuestions.length}',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            TextButton(
              onPressed: () {
                // 처음으로 돌아가기
                setState(() {
                  isProFarmer = null;
                  currentIndex = 0;
                  qaPairs.clear();
                });
              },
              child: Text('처음으로'),
            ),
          ],
        ),
      ),
    );
  }
}
