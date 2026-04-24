import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:merhaba/core/utils/providers/profile_tab_provider.dart';

class ProfileImageFilled extends StatelessWidget {
  const ProfileImageFilled({
    super.key,
    required this.profileTabProvider,
    this.post = const {},
    this.height = 100,
    this.width = 100,
  });

  final ProfileTabProvider? profileTabProvider;
  final Map<String, dynamic> post;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          (profileTabProvider?.photoUrl != null &&
              profileTabProvider!.photoUrl.isNotEmpty)
          ? profileTabProvider!.photoUrl
          : (post["user_photo"] ?? ""),

      //  profileTabProvider?.photoUrl == ""
      //     ? post["user_photo"] ?? ""
      //     : profileTabProvider?.photoUrl ?? "",
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
