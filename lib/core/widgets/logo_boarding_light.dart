import 'package:flutter/material.dart';
import 'package:merhaba/core/utils/assets_utils.dart';

class LogoOnboardingLight extends StatelessWidget {
  const LogoOnboardingLight({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsUtils.appIconLight,
      //  width: ( MediaQuery.sizeOf(context).width - 60) * 0.5,
    );
  }
}
