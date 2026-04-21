import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merhaba/core/routing/app_router.dart';
import 'package:merhaba/core/utils/controllers/auth_controller.dart';
import 'package:merhaba/core/utils/funcs/getPostsAndNavigate_method.dart';
import 'package:merhaba/core/utils/providers/timeline_provider.dart';
import 'package:merhaba/core/widgets/logo_boarding_light.dart';
import 'package:provider/provider.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  Timer? timer;
  int timerStart = 2;

  void startTimer() {
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

  Future<void> checkLogin() async {
    try {
      var res = await AuthController.checkLogin();
      if (res["result"] == true) {
        getPostsAndNavigateMethod(context);
      } else {

        
        context.go(AppRouter.kLoginView);
      }
    } catch (e) {
      debugPrint(e.toString());
      context.go(AppRouter.kLoginView);
    }
  }

 

  @override
  void initState() {
    super.initState();
    // startTimer();
    checkLogin();
  }

  @override
  void dispose() {
    //timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: LogoOnboardingLight()));
  }
}
