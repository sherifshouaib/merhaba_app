import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merhaba/core/helper/spacing.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/routing/app_router.dart';
import 'package:merhaba/core/utils/controllers/posts_controller.dart';
import 'package:merhaba/core/utils/providers/new_post_provider.dart';
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

    final newPostProvider = Provider.of<NewPostProvider>(context);
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
        body: newPostProvider.isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      CustomProfilePhoto(
                        profileTabProvider: profileTabProvider,
                        height: 30,
                        width: 30,
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
                            DropdownButton<String>(
                              isDense: true,
                              underline: Container(),
                              value: newPostProvider.currentPostMode,
                              onChanged: (String? value) {
                                if (value == null) return;
                                newPostProvider.setCurrentPostMode(value);
                              },
                              items: newPostProvider
                                  .getVisibilityOptions(context)
                                  .map<DropdownMenuItem<String>>((
                                    Map<String, dynamic> value,
                                  ) {
                                    return DropdownMenuItem<String>(
                                      value: value["value"],
                                      child: Row(
                                        children: [
                                          value['icon'],

                                          horizontalSpace(10),
                                          Text(value['label']),
                                        ],
                                      ),
                                    );
                                  })
                                  .toList(),
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
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: AppLocale.type_something_label.getString(
                        context,
                      ),
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
                          onTap: () async {
                            await showDialog<String>(
                              context: context,
                              builder: (context) => fluent.ContentDialog(
                                // title: const Text('Change Profile Picture ?'),
                                // content: const Text(
                                //   'Choose the source that you want to get the new picture from',
                                // ),
                                actions: [
                                  FilledButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                        Colors.purple,
                                      ),
                                    ),
                                    onPressed: () async {
                                      ImagePicker imagePicker = ImagePicker();
                                      var file = await imagePicker.pickImage(
                                        source: ImageSource.camera,
                                        imageQuality: 50,
                                      );
                                      if (file == null) {
                                        Navigator.of(context).pop();
                                        return;
                                      }
                                      //  print("Photo >>>>>>>>>>>>>${file.name}");

                                      var uploadRes =
                                          await PostsController.uploadPostMedia(
                                            File(file.path),
                                          );
                                        print(uploadRes);


                                      if (uploadRes["result"] == true) {
                                        var url = uploadRes["url"];
                                        var fileName = uploadRes["fileName"];

                                        newPostProvider.addNewPhoto({
                                          "url": url,
                                          "fileName": fileName,
                                        });
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: uploadRes["message"].toString(),
                                        );
                                      }

                                      Navigator.of(context).pop();

                                      // if (file != null) {
                                      //   //    profileTabProvider.toggleLoading();
                                      //   try {
                                      //     String originalFilename = path
                                      //         .basename(file.path);
                                      //     String extension = path.extension(
                                      //       file.path,
                                      //     );
                                      //     String fileName =
                                      //         "${DateTime.now().toIso8601String().replaceAll('.', '').replaceAll(' ', '')}_$originalFilename";
                                      //     //  debugPrint(fileName);

                                      //     final String fullPath = await Supabase
                                      //         .instance
                                      //         .client
                                      //         .storage
                                      //         .from('Users')
                                      //         .upload(
                                      //           fileName,
                                      //           File(file.path),
                                      //         );

                                      //     final String url = await Supabase
                                      //         .instance
                                      //         .client
                                      //         .storage
                                      //         .from("Users")
                                      //         .getPublicUrl(fileName);
                                      //     await profileTabProvider
                                      //         .updateUserProfilePicture(url);
                                      //     Navigator.of(context).pop();
                                      //   } catch (e) {
                                      //     debugPrint(e.toString());
                                      //   }
                                      //   // profileTabProvider.toggleLoading();
                                      // }
                                    },

                                    child: Text(
                                      AppLocale.camera_label.getString(context),
                                    ),
                                  ),
                                  FilledButton(
                                    child: Text(
                                      AppLocale.gallery_label.getString(
                                        context,
                                      ),
                                    ),
                                    onPressed: () async {
                                      ImagePicker imagePicker = ImagePicker();
                                      var files = await imagePicker
                                          .pickMultiImage(imageQuality: 50);

                                      for (var file in files) {
                                        var uploadRes =
                                            await PostsController.uploadPostMedia(
                                              File(file.path),
                                            );

                                        print(uploadRes);

                                        if (uploadRes["result"] == true) {
                                          var url = uploadRes["url"];
                                          var fileName = uploadRes["fileName"];

                                          newPostProvider.addNewPhoto({
                                            "url": url,
                                            "fileName": fileName,
                                          });
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: uploadRes["message"]
                                                .toString(),
                                          );
                                        }
                                      }
                                      Navigator.of(context).pop();

                                      // if (file != null) {
                                      // if (file != null) {
                                      //   //    profileTabProvider.toggleLoading();
                                      //   try {
                                      //     String originalFilename = path
                                      //         .basename(file.path);
                                      //     String extension = path.extension(
                                      //       file.path,
                                      //     );
                                      //     String fileName =
                                      //         "${DateTime.now().toIso8601String().replaceAll('.', '').replaceAll(' ', '')}_$originalFilename";
                                      //     //  debugPrint(fileName);

                                      //     final String fullPath = await Supabase
                                      //         .instance
                                      //         .client
                                      //         .storage
                                      //         .from('Users')
                                      //         .upload(
                                      //           fileName,
                                      //           File(file.path),
                                      //         );

                                      //     final String url = await Supabase
                                      //         .instance
                                      //         .client
                                      //         .storage
                                      //         .from("Users")
                                      //         .getPublicUrl(fileName);
                                      //     await profileTabProvider
                                      //         .updateUserProfilePicture(url);
                                      //     Navigator.of(context).pop();
                                      //   } catch (e) {
                                      //     debugPrint(e.toString());
                                      //   }
                                      //   // profileTabProvider.toggleLoading();
                                      // }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },

                          //////////////////////////////////////////////////////
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
