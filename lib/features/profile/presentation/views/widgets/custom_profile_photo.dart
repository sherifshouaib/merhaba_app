import 'package:flutter/material.dart';
import 'package:merhaba/core/utils/providers/profile_tab_provider.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/profile_image_empty.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/profile_image_filled.dart';

class CustomProfilePhoto extends StatelessWidget {
  const CustomProfilePhoto({
    super.key,
    this.profileTabProvider,
    this.post = const {},
    this.height = 100,
    this.width = 100,
  });

  final ProfileTabProvider? profileTabProvider;
  final double height, width;
  final Map<String, dynamic> post;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        profileTabProvider?.photoUrl == "" && post["user_photo"] == null
            ? ProfileImageEmpty(height: height, width: width)
            : ProfileImageFilled(
                profileTabProvider: profileTabProvider,
                height: height,
                width: width,
                post: post,
              ),
      ],
    );
  }
}
