 import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:merhaba/core/routing/app_router.dart';
import 'package:merhaba/core/utils/providers/timeline_provider.dart';
import 'package:provider/provider.dart';

void getPostsAndNavigateMethod(BuildContext context) {
      final timelineProvider = Provider.of<TimelineProvider>(context);
    timelineProvider.getData();
    
    context.go(AppRouter.kHomeView);
  }