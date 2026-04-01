import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/routing/app_router.dart';
import 'package:merhaba/core/utils/providers/profile_tab_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../core/helper/spacing.dart';

class HomeTabViewBody extends StatelessWidget {
  const HomeTabViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 5),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        InkWell(
          onTap: () async {
            final profileTabProvider = Provider.of<ProfileTabProvider>(
              context,
              listen: false,
            );

            await profileTabProvider.getData();
            AppRouter.router.push(AppRouter.kNewPostView);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.withOpacity(0.05),
            ),

            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                verticalSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: (MediaQuery.sizeOf(context).width - 60) * 0.6,
                      child: Text(
                        AppLocale.whats_on_your_mind_label.getString(context),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const Icon(Icons.photo),
                  ],
                ),

                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
