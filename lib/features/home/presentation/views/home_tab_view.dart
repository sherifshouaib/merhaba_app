import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/features/home/presentation/views/widgets/home_tab_view_body.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title:
            Text(
                  // AppLocale.home_label.getString(context),
                  "MERHABA",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 3000.ms, color: const Color(0xFF80DDFF))
                .animate(
                  // onPlay: (controller) => controller.repeat(),
                ) // this wraps the previous Animate in another Animate
                .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
                .slide(),
      ),
      body: HomeTabViewBody(),
    );
  }
}
