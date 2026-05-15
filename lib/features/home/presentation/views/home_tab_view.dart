import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:merhaba/core/utils/providers/timeline_provider.dart';
import 'package:merhaba/features/home/presentation/views/widgets/home_tab_view_body.dart';
import 'package:provider/provider.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final timeLineProvider = Provider.of<TimelineProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title:
            Text(
                  // AppLocale.home_label.getString(context),
                  //  "MERHABA",
                  "MAJMAA",
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
      body: SwipeRefresh.adaptive(
        stateStream: timeLineProvider.swipeStream,
        onRefresh: timeLineProvider.onRefresh,
        padding: EdgeInsets.symmetric(vertical: 10),
        children: [HomeTabViewBody()],
      ),
    );
  }
}
