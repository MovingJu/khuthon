import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:khuthon/data/task_rules.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  Hive.registerAdapter(CropDataAdapter());
  await Hive.openBox<CropData>('crops');
  print('🔍 Firebase 초기화 준비중...');

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: dotenv.env['API_KEY']!,
        authDomain: dotenv.env['AUTH_DOMAIN']!,
        projectId: dotenv.env['PROJECT_ID']!,
        storageBucket: dotenv.env['STORAGE_BUCKET']!,
        messagingSenderId: dotenv.env['MESSAGING_SENDER_ID']!,
        appId: dotenv.env['APP_ID']!,
        measurementId: dotenv.env['MEASUREMENT_ID'],
      ),
    );

    print('✅ 웹: Firebase 초기화 완료');
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  } else {
    await Firebase.initializeApp();
    print('✅ 모바일: Firebase 초기화 완료');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '작물픽',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: const AuthGate(),
    );
  }
}

// ✅ 로그인 상태 감지 위젯
class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          return const HomePage(); // 로그인 되어 있으면 홈으로
        } else {
          return const SettingsScreen(); // 로그인 필요 시 로그인 화면
        }
      },
    );
  }
}
