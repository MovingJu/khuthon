import 'dart:html' as html; // 웹 세션 스토리지용
import 'package:flutter/foundation.dart' show kIsWeb; // kIsWeb 확인용
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ✅ 추가


class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool? _isLoggedIn; // 세션 기준으로 판단

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  void _checkSession() {
    if (kIsWeb) {
      final sessionLogin = html.window.sessionStorage['isLoggedIn'];
      setState(() {
        _isLoggedIn = sessionLogin == 'true';
      });
    } else {
      // 모바일이면 Firebase Auth만 사용
      _isLoggedIn = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn == true) {
      // 세션에 로그인 기록이 있으면 바로 홈으로
      return const HomePage();
    }

    // 세션 없으면 Firebase Auth 스트림 확인
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const SettingsScreen();
        }
      },
    );
  }
}
