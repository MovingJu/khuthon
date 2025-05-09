import 'package:flutter/material.dart';
import '../services/gpt_service.dart';
import 'result_screen.dart';

class InputScreen extends StatefulWidget {
  final List<Map<String, dynamic>> qaPairs; // 설문 결과

  const InputScreen({super.key, required this.qaPairs});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  bool _isLoading = false;
  String? _gptPrompt;

  // 질문-답변 쌍을 프롬프트로 변환
  String qaPairsToPrompt(List<Map<String, dynamic>> qaPairs) {
    return qaPairs.map((qa) => '${qa['question']}\n답: ${qa['answer']}').join('\n\n');
  }

  Future<void> _sendMessage() async {
    final prompt = qaPairsToPrompt(widget.qaPairs);
    setState(() {
      _isLoading = true;
      _gptPrompt = prompt;
    });

    try {
      final reply = await GptService.sendMessage(prompt);

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen(result: reply)),
      );

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('에러 발생'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('닫기'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final prompt = qaPairsToPrompt(widget.qaPairs);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            '아래 설문 결과가 GPT 프롬프트로 사용됩니다:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey[200],
            child: Text(prompt),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _isLoading ? null : _sendMessage,
            child: const Text('GPT에게 추천 요청'),
          ),
          if (_isLoading) const SizedBox(height: 24),
          if (_isLoading) const CircularProgressIndicator(),
        ],
      ),
    );
  }
}