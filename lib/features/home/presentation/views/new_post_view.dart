import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/helper/spacing.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/routing/app_router.dart';
import 'package:merhaba/core/utils/providers/profile_tab_provider.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/custom_profile_photo.dart';
import 'package:merhaba/main_development.dart';
import 'package:provider/provider.dart';

class NewPostView extends StatelessWidget {
  const NewPostView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileTabProvider = Provider.of<ProfileTabProvider>(
      context,
      listen: false,
    );
    final List<String> list = <String>[
      AppLocale.public_label.getString(context),
      AppLocale.friends_label.getString(context),
      AppLocale.only_me_label.getString(context),
    ];
    return Directionality(
      textDirection: localization.currentLocale.localeIdentifier == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              AppRouter.router.pop();
            },
            icon: Icon(Icons.close),
          ),
          centerTitle: true,
          actions: [
            ElevatedButton(
              onPressed: () {},
              child: Text(AppLocale.save_label.getString(context)),
            ),
          ],
          title: Text(AppLocale.new_post_label.getString(context)),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                CustomProfilePhoto(
                  profileTabProvider: profileTabProvider,
                  height: 40,
                  width: 40,
                ),
                horizontalSpace(15),
                SizedBox(
                  width: (MediaQuery.sizeOf(context).width - 65) * 0.4,

                  child: Text(
                    profileTabProvider.username,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.sizeOf(context).width - 65) * 0.59,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DropdownMenu<String>(
                        initialSelection: list.first,
                        onSelected: (String? value) {},
                        dropdownMenuEntries: list
                            .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                value: value,
                                label: value,
                              );
                            })
                            .toList(),

                        inputDecorationTheme: InputDecorationTheme(
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            verticalSpace(30),
            TextFormField(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.all(0),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                hintText: AppLocale.type_something_label.getString(context),
              ),

              // minLines: 3,
              maxLines: null,
            ),

            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  ListTile(
                    dense: true,
                    trailing: const Icon(Icons.photo),
                    onTap: () {},
                    title: Text(
                      AppLocale.photo_label.getString(context),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  verticalSpace(5),
                  ListTile(
                    dense: true,
                    trailing: const Icon(Icons.video_camera_back),
                    onTap: () {},
                    title: Text(
                      AppLocale.video_label.getString(context),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  verticalSpace(5),
                  ListTile(
                    dense: true,
                    trailing: const Icon(Icons.location_pin),
                    onTap: () {},
                    title: Text(
                      AppLocale.location_label.getString(context),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  verticalSpace(5),
                  ListTile(
                    dense: true,
                    trailing: const Icon(Icons.announcement),
                    onTap: () {},
                    title: Text(
                      AppLocale.occasion_label.getString(context),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
