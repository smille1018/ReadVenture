/// File: login_page.dart
/// Purpose: 사용자 로그인 화면, Google, Apple, Kakao 로그인 버튼 제공
/// Author: 박민준
/// Created: 2025-01-01
/// Last Modified: 2025-02-03 by 박민준

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readventure/theme/font.dart';
import 'package:readventure/theme/theme.dart';
import '../../viewmodel/custom_colors_provider.dart';
import '../home/attendance/attendance_provider.dart';
import 'auth_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authControllerProvider.notifier);
    final customColors = ref.watch(customColorsProvider); // CustomColors 가져오기

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              customColors.neutral100 ?? Colors.blue,  // Start color of the gradient
              customColors.primary10 ?? Colors.green, // End color of the gradient
            ],
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  child: Center(
                    child: SvgPicture.asset("assets/icons/app_login_logo.svg"),
                  )
              ),
              GestureDetector(
                onTap: () {
                  authController.signInWithGoogle(
                    onNicknameRequired: () {
                      Navigator.pushReplacementNamed(context, '/nickname');
                    },
                    onHome: () {
                      Navigator.pushReplacementNamed(context, '/');
                      ref.refresh(attendanceProvider);
                    },
                  );
                },
                child: GoogleLoginButton(customColors: customColors),
              ),
              SizedBox(height: 16,),
              // Apple 로그인 버튼 (수정됨)
              GestureDetector(
                onTap: () {
                  authController.signInWithApple(
                    onNicknameRequired: () {
                      Navigator.pushReplacementNamed(context, '/nickname');
                    },
                    onHome: () {
                      Navigator.pushReplacementNamed(context, '/');
                      ref.refresh(attendanceProvider);
                    },
                  );
                },
                child: AppleLoginButton(customColors: customColors),
              ),
              // Kakao 로그인 버튼
              SizedBox(height: 16,),
              GestureDetector(
                onTap: () {
                  authController.signInWithKakao(
                    onNicknameRequired: () {
                      Navigator.pushReplacementNamed(context, '/nickname');
                    },
                    onHome: () {
                      Navigator.pushReplacementNamed(context, '/');
                      ref.refresh(attendanceProvider);
                    },
                  );
                },
                child: KakaoLoginButton(customColors: customColors),
              ),
              SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({
    super.key,
    required this.customColors,
  });

  final CustomColors customColors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 64,
        padding: EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: customColors.neutral100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              child: Image.asset("assets/icons/google.png"),
            ),
            SizedBox(width: 16,),
            Text("Google로 계속하기", style: body_medium_semi(context).copyWith(color: customColors.neutral30),)
          ],
        ),
      ),
    );
  }
}

class AppleLoginButton extends StatelessWidget {
  const AppleLoginButton({
    super.key,
    required this.customColors,
  });

  final CustomColors customColors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 64,
        padding: EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: customColors.neutral0,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 24,
              height: 24,
              child: Image.asset("assets/icons/apple_icon_white.png"),
            ),
            SizedBox(width: 16,),
            Text("Apple로 계속하기", style: body_medium_semi(context).copyWith(color: customColors.neutral100),)
          ],
        ),
      ),
    );
  }
}

class KakaoLoginButton extends StatelessWidget {
  const KakaoLoginButton({
    super.key,
    required this.customColors,
  });

  final CustomColors customColors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
          color: Color(0xFFFAE100),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 24,
              height: 24,
              child: Image.asset("assets/icons/kakao_icon.png"),
            ),
            SizedBox(width: 16,),
            Text("카카오로 계속하기", style: body_medium_semi(context).copyWith(color: customColors.neutral30),)
          ],
        ),
      ),
    );
  }
}
