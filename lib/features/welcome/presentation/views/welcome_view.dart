import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merhaba/core/routing/app_router.dart';
import 'package:merhaba/core/widgets/logo_boarding_light.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  Timer? timer;
  int timerStart = 2;

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerStart == 0) {
        timer?.cancel();
        context.go(AppRouter.kLoginView);
      } else {
        setState(() {
          timerStart--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: LogoOnboardingLight()));
  }
}
