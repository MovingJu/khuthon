import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import '../services/syncdata_service.dart';
import '../data/task_rules.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
  );

  User? _user;
  GoogleSignInAccount? _googleUser;

  @override
  void initState() {
    super.initState();
    _restoreSession();
  }

  Future<void> _restoreSession() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final googleUser = await _googleSignIn.signInSilently(); // ✅ 세션 복원
    if (currentUser != null) {
      setState(() {
        _user = currentUser;
        _googleUser = googleUser;
      });
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
        _googleUser = googleUser; // ✅ 구글 계정 저장
      });

      print('로그인 성공: ${_user?.displayName}');
      await SyncService.downloadFirestoreToHive(); //계정 바꿀 시 동기화
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
                      backgroundImage:
                          _user?.photoURL != null && _user!.photoURL!.isNotEmpty
                              ? NetworkImage(_user!.photoURL!)
                              : (_googleUser?.photoUrl != null &&
                                      _googleUser!.photoUrl!.isNotEmpty
                                  ? NetworkImage(_googleUser!.photoUrl!)
                                  : const AssetImage(
                                        'assets/default_profile.png',
                                      )
                                      as ImageProvider),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _user?.displayName ?? _googleUser?.displayName ?? '이름 없음',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _user?.email ?? _googleUser?.email ?? '이메일 없음',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        await _googleSignIn.signOut();
                        setState(() {
                          _user = null;
                          _googleUser = null;
                        });
                        final box = Hive.box<CropData>('crops');
                        await box.clear();
                      },
                      child: const Text('로그아웃'),
                    ),
                  ],
                ),
      ),
    );
  }
}
