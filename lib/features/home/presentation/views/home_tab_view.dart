import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/features/home/presentation/views/widgets/home_tab_view_body.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocale.home_label.getString(context)),
      ),
      body: HomeTabViewBody(),
    );
  }
}
