import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool? _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  void _checkSession() {
    // 모바일에서는 Firebase Auth 상태만 확인
    final currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      _isLoggedIn = currentUser != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn == true) {
      return const HomePage();
    }

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
