import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GptService {
  static Future<String> sendMessage(String message) async {
    final apiKey = dotenv.env['OPENAI_API_KEY'];

    print('✅ dotenv loaded: ${dotenv.isInitialized}');
    print('✅ API Key: ${dotenv.env['OPENAI_API_KEY']}');

    // ✅ 환경변수 확인 (디버깅용)
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('❗ API 키가 비어있습니다. dotenv가 로드되었는지 확인하세요.');
    }

    const apiUrl = 'https://api.openai.com/v1/chat/completions';

    try {
      final response = await http
          .post(
            Uri.parse(apiUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $apiKey',
            },
            body: json.encode({
              'model': 'gpt-3.5-turbo',
              'messages': [
                {
                  'role': 'system',
                  'content': '''
넌 스마트 작물 추천 시스템이야. 유저는 식물을 얼마나 자주 가꿀 수 있는지, 빛의 세기(빛이 얼마나 잘 드는지) 등의 정보를 제공할 거야. 넌 이 정보를 기반으로 **총 5개의 키우기 좋은 식물 또는 재배용 작물**을 추천해주면 돼.

반드시 **JSON 배열 형식**으로 답변해야 하며, 각 아이템의 필드는 다음과 같다:

- "name": 식물명 또는 작물명 (예: "산세베리아")
- "waterCycle": 물을 주는 주기 (예: "2주에 한 번 물주기")
- "lightNeeds": 빛이 얼마나 필요한지 (예: "빛이 적어도 잘 자람")
- "description": 특징 및 특이사항 (예: "공기 정화 능력이 뛰어나며, 초보자도 키우기 쉬움. 공기가 탁한 실내에서도 잘 자라며 관리가 편하다.")

**형식 예시:**

[
  {
    "name": "산세베리아",
    "waterCycle": "2주에 한 번 물주기",
    "lightNeeds": "빛이 적어도 잘 자람",
    "description": "공기 정화 능력이 뛰어나며, 초보자도 키우기 쉬움. 공기가 탁한 실내에서도 잘 자라며 관리가 편하다."
  },
  {
    "name": "방울토마토",
    "waterCycle": "매일 소량의 물주기",
    "lightNeeds": "햇빛이 매우 많이 필요함",
    "description": "과실이 풍부하게 열리고 비타민C가 많아 식용으로 아주 좋음. 지지대를 세우면 더 건강하게 자람."
  }
]

**주의사항:**
- 반드시 JSON 배열만 출력해야 해. 다른 말이나 설명을 추가하지 마라.
- 특징 항목은 자세하게 작성해.
''',
                },
                {'role': 'user', 'content': message},
              ],
            }),
          )
          .timeout(const Duration(seconds: 30)); // ✅ 타임아웃 추가

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // ✅ 방어 코드 추가: 응답 구조 확인
        if (data['choices'] != null &&
            data['choices'].isNotEmpty &&
            data['choices'][0]['message'] != null &&
            data['choices'][0]['message']['content'] != null) {
          return data['choices'][0]['message']['content'].trim();
        } else {
          throw Exception('❗ 예상치 못한 응답 형식: ${response.body}');
        }
      } else {
        throw Exception('❗ 에러 발생: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // ✅ 모든 예외 캐치해서 로그로 남김
      print('❗ GPT API 호출 중 오류: $e');
      rethrow; // 다시 던져서 상위에서 처리 가능하게
    }
  }
}
