import 'package:flutter/material.dart';
import 'package:merhaba/core/utils/assets_utils.dart';

class ProfileImageEmpty extends StatelessWidget {
  const ProfileImageEmpty({super.key, this.height = 100, this.width = 100});

  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        image: DecorationImage(image: AssetImage(AssetsUtils.profileAvatar)),
      ),
    );
  }
}
