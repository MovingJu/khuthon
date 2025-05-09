import 'package:flutter/material.dart';
import '../services/gpt_service.dart';
import 'result_screen.dart';

class InputScreen extends StatefulWidget {
  final List<Map<String, dynamic>> qaPairs;

  const InputScreen({super.key, required this.qaPairs});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  @override
  void initState() {
    super.initState();
    _sendMessage();
  }

  String qaPairsToPrompt(List<Map<String, dynamic>> qaPairs) {
    return qaPairs.map((qa) => '${qa['question']}\n답: ${qa['answer']}').join('\n\n');
  }

  Future<void> _sendMessage() async {
    final prompt = qaPairsToPrompt(widget.qaPairs);

    try {
      final reply = await GptService.sendMessage(prompt);
      print(reply);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen(result: reply)),
      );
    } catch (e) {
      if (!mounted) return;
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
    // 로딩 인디케이터만 보여줌
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
