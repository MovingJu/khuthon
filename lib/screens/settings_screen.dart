  import 'package:flutter/material.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:google_sign_in/google_sign_in.dart';
  import 'package:flutter/foundation.dart' show kIsWeb;
  import 'dart:html' as html; // ✅ 웹 세션용 추가

  class SettingsScreen extends StatefulWidget {
    const SettingsScreen({super.key});

    @override
    State<SettingsScreen> createState() => _SettingsScreenState();
  }

  class _SettingsScreenState extends State<SettingsScreen> {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    User? _user;

    @override
    void initState() {
      super.initState();
      _restoreSession(); // ✅ 세션에서 로그인 상태 복구 시도
    }

    Future<void> _restoreSession() async {
      if (kIsWeb) {
        final isLoggedIn = html.window.sessionStorage['isLoggedIn'];
        if (isLoggedIn == 'true') {
          final currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser != null) {
            setState(() {
              _user = currentUser;
            });
          }
        }
      } else {
        // 모바일: FirebaseAuth 상태만 보면 됨
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          setState(() {
            _user = currentUser;
          });
        }
      }
    }

    Future<void> _handleGoogleSignIn() async {
      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          print('사용자가 로그인 취소함');
          return;
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(credential);

        setState(() {
          _user = userCredential.user;
        });

        // ✅ 세션에 로그인 상태 저장 (웹 전용)
        if (kIsWeb) {
          html.window.sessionStorage['isLoggedIn'] = 'true';
        }

        print('로그인 성공: ${_user?.displayName}');
      } catch (e) {
        print('로그인 실패: $e');
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text('Google 로그인')),
        body: Center(
          child:
              _user == null
                  ? ElevatedButton(
                    onPressed: _handleGoogleSignIn,
                    child: const Text('구글로 로그인하기'),
                  )
                  : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(_user?.photoURL ?? ''),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _user?.displayName ?? '이름 없음',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _user?.email ?? '이메일 없음',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          await _googleSignIn.signOut();

                          // ✅ 세션 초기화 (웹 전용)
                          if (kIsWeb) {
                            html.window.sessionStorage.remove('isLoggedIn');
                          }

                          setState(() {
                            _user = null;
                          });
                        },
                        child: const Text('로그아웃'),
                      ),
                    ],
                  ),
        ),
      );
    }
  }
