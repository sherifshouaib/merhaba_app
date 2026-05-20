import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merhaba/core/helper/spacing.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/utils/providers/post_provider.dart';
import 'package:merhaba/features/home/presentation/views/widgets/post_widget.dart';
import 'package:merhaba/features/posts/presentation/views/widgets/comment_widget.dart';
import 'package:merhaba/main_development.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/controllers/comments_controller.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    return Directionality(
      textDirection: localization.currentLocale.localeIdentifier == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(AppLocale.post_label.getString(context)),
          ),
          body: Stack(
            children: [
              ListView(
                // mainAxisSize: MainAxisSize.min,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  PostWidget(
                    post: postProvider.currentPost,
                    showActions: true,
                    canNavigate: false,
                  ),
                  verticalSpace(3),

                  // Comments here
                  ...postProvider.comments.map(
                    (comment) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      child: fluent.SizedBox(
                        width: (MediaQuery.sizeOf(context).width - 60) * 0.6,
                        child: CommentWidget(
                          comment: comment,
                          //  post: postProvider.currentPost,
                        ),
                      ),
                    ),
                  ),

                  verticalSpace(100),
                ],
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: (MediaQuery.sizeOf(context).width),
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: Colors.blueGrey.withOpacity(0.8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      // InkWell(child: Icon(Icons.add), onTap: () {}),
                      // horizontalSpace(10),
                      InkWell(
                        child: Icon(Icons.photo_camera_outlined),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_1) => fluent.ContentDialog(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocale.choose_media_label.getString(
                                      context,
                                    ),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              content: Directionality(
                                textDirection:
                                    localization
                                            .currentLocale
                                            .localeIdentifier ==
                                        "ar"
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Material(
                                      child: ListTile(
                                        title: Text(
                                          AppLocale.photo_label.getString(
                                            context,
                                          ),
                                        ),
                                        dense: true,
                                        visualDensity: VisualDensity.compact,
                                        onTap: () {
                                          showDialog(
                                            context: _1,
                                            builder: (_2) => fluent.ContentDialog(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    AppLocale
                                                        .choose_source_label
                                                        .getString(context),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              content: Directionality(
                                                textDirection:
                                                    localization
                                                            .currentLocale
                                                            .localeIdentifier ==
                                                        "ar"
                                                    ? TextDirection.rtl
                                                    : TextDirection.ltr,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Material(
                                                      child: ListTile(
                                                        title: Text(
                                                          AppLocale.camera_label
                                                              .getString(
                                                                context,
                                                              ),
                                                        ),
                                                        dense: true,
                                                        visualDensity:
                                                            VisualDensity
                                                                .compact,

                                                        onTap: () async {
                                                          postProvider
                                                              .setIsLoading(
                                                                true,
                                                              );
                                                          try {
                                                            ImagePicker
                                                            imagePicker =
                                                                ImagePicker();

                                                            var file = await imagePicker
                                                                .pickImage(
                                                                  source:
                                                                      ImageSource
                                                                          .camera,
                                                                  imageQuality:
                                                                      50,
                                                                );
                                                            if (file != null) {
                                                              var res =
                                                                  await CommentsController.uploadCommentImage(
                                                                    File(
                                                                      file.path,
                                                                    ),
                                                                  );
                                                              if (res["result"] ==
                                                                  true) {
                                                                postProvider
                                                                    .setAddMediaUrl(
                                                                      res["url"]
                                                                          .toString(),
                                                                    );

                                                                await postProvider
                                                                    .onAddPhoto(
                                                                      _1,
                                                                    );
                                                                Navigator.of(
                                                                  _2,
                                                                ).pop();
                                                                Navigator.of(
                                                                  _1,
                                                                ).pop();
                                                              } else {
                                                                Fluttertoast.showToast(
                                                                  msg: res["message"]
                                                                      .toString(),
                                                                );
                                                              }
                                                            }
                                                          } catch (e) {
                                                            debugPrint(
                                                              e.toString(),
                                                            );
                                                          }

                                                          postProvider
                                                              .setIsLoading(
                                                                false,
                                                              );
                                                        },

                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                15,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    verticalSpace(5),
                                                    Material(
                                                      child: ListTile(
                                                        title: Text(
                                                          AppLocale
                                                              .gallery_label
                                                              .getString(
                                                                context,
                                                              ),
                                                        ),
                                                        dense: true,
                                                        visualDensity:
                                                            VisualDensity
                                                                .compact,

                                                        onTap: () async {
                                                          postProvider
                                                              .setIsLoading(
                                                                true,
                                                              );
                                                          try {
                                                            ImagePicker
                                                            imagePicker =
                                                                ImagePicker();

                                                            var file = await imagePicker
                                                                .pickImage(
                                                                  source:
                                                                      ImageSource
                                                                          .gallery,
                                                                  imageQuality:
                                                                      50,
                                                                );
                                                            if (file != null) {
                                                              var res =
                                                                  await CommentsController.uploadCommentImage(
                                                                    File(
                                                                      file.path,
                                                                    ),
                                                                  );
                                                              if (res["result"] ==
                                                                  true) {
                                                                postProvider
                                                                    .setAddMediaUrl(
                                                                      res["url"]
                                                                          .toString(),
                                                                    );

                                                                await postProvider
                                                                    .onAddPhoto(
                                                                      _1,
                                                                    );
                                                                Navigator.of(
                                                                  _2,
                                                                ).pop();
                                                                Navigator.of(
                                                                  _1,
                                                                ).pop();
                                                              } else {
                                                                Fluttertoast.showToast(
                                                                  msg: res["message"]
                                                                      .toString(),
                                                                );
                                                              }
                                                            }
                                                          } catch (e) {
                                                            debugPrint(
                                                              e.toString(),
                                                            );
                                                          }

                                                          postProvider
                                                              .setIsLoading(
                                                                false,
                                                              );
                                                        },

                                                        // onTap: () {},
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                15,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    verticalSpace(5),
                                    Material(
                                      child: ListTile(
                                        title: Text(
                                          AppLocale.video_label.getString(
                                            context,
                                          ),
                                        ),
                                        dense: true,
                                        visualDensity: VisualDensity.compact,
                                        onTap: () {
                                          showDialog(
                                            context: _1,
                                            builder: (_2) => fluent.ContentDialog(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    AppLocale
                                                        .choose_source_label
                                                        .getString(context),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              content: Directionality(
                                                textDirection:
                                                    localization
                                                            .currentLocale
                                                            .localeIdentifier ==
                                                        "ar"
                                                    ? TextDirection.rtl
                                                    : TextDirection.ltr,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Material(
                                                      child: ListTile(
                                                        title: Text(
                                                          AppLocale.camera_label
                                                              .getString(
                                                                context,
                                                              ),
                                                        ),
                                                        dense: true,
                                                        visualDensity:
                                                            VisualDensity
                                                                .compact,

                                                        onTap: () async {
                                                          postProvider
                                                              .setIsLoading(
                                                                true,
                                                              );
                                                          try {
                                                            ImagePicker
                                                            imagePicker =
                                                                ImagePicker();

                                                            var file = await imagePicker
                                                                .pickVideo(
                                                                  source:
                                                                      ImageSource
                                                                          .camera,
                                                                );
                                                            if (file != null) {
                                                              var res =
                                                                  await CommentsController.uploadCommentVideo(
                                                                    File(
                                                                      file.path,
                                                                    ),
                                                                  );
                                                              if (res["result"] ==
                                                                  true) {
                                                                postProvider
                                                                    .setAddMediaUrl(
                                                                      res["url"]
                                                                          .toString(),
                                                                    );

                                                                await postProvider
                                                                    .onAddVideo(
                                                                      _1,
                                                                    );
                                                                Navigator.of(
                                                                  _2,
                                                                ).pop();
                                                                Navigator.of(
                                                                  _1,
                                                                ).pop();
                                                              } else {
                                                                Fluttertoast.showToast(
                                                                  msg: res["message"]
                                                                      .toString(),
                                                                );
                                                              }
                                                            }
                                                          } catch (e) {
                                                            debugPrint(
                                                              e.toString(),
                                                            );
                                                          }

                                                          postProvider
                                                              .setIsLoading(
                                                                false,
                                                              );
                                                        },

                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                15,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    verticalSpace(5),
                                                    Material(
                                                      child: ListTile(
                                                        title: Text(
                                                          AppLocale
                                                              .gallery_label
                                                              .getString(
                                                                context,
                                                              ),
                                                        ),
                                                        dense: true,
                                                        visualDensity:
                                                            VisualDensity
                                                                .compact,

                                                        onTap: () async {
                                                          postProvider
                                                              .setIsLoading(
                                                                true,
                                                              );
                                                          try {
                                                            ImagePicker
                                                            imagePicker =
                                                                ImagePicker();

                                                            var file = await imagePicker
                                                                .pickVideo(
                                                                  source:
                                                                      ImageSource
                                                                          .gallery,
                                                                );
                                                            if (file != null) {
                                                              var res =
                                                                  await CommentsController.uploadCommentVideo(
                                                                    File(
                                                                      file.path,
                                                                    ),
                                                                  );
                                                              if (res["result"] ==
                                                                  true) {
                                                                postProvider
                                                                    .setAddMediaUrl(
                                                                      res["url"]
                                                                          .toString(),
                                                                    );

                                                                await postProvider
                                                                    .onAddVideo(
                                                                      _1,
                                                                    );
                                                                Navigator.of(
                                                                  _2,
                                                                ).pop();
                                                                Navigator.of(
                                                                  _1,
                                                                ).pop();
                                                              } else {
                                                                Fluttertoast.showToast(
                                                                  msg: res["message"]
                                                                      .toString(),
                                                                );
                                                              }
                                                            }
                                                          } catch (e) {
                                                            debugPrint(
                                                              e.toString(),
                                                            );
                                                          }

                                                          postProvider
                                                              .setIsLoading(
                                                                false,
                                                              );
                                                        },

                                                        // onTap: () {},
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                15,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      horizontalSpace(10),

                      Expanded(
                        child: fluent.TextBox(
                          placeholder: AppLocale.comment_label.getString(
                            context,
                          ),
                          expands: false,
                          controller: postProvider.newCommentController,
                          focusNode: postProvider.newCommentFocusNode,
                          onChanged: (value) {
                            postProvider.setIsNewCommentEmpty(value.isEmpty);
                          },
                        ),
                      ),

                      horizontalSpace(10),
                      if (!(postProvider.isNewCommentEmpty))
                        InkWell(
                          child: Icon(Icons.send),
                          onTap: () async {
                            await postProvider.onAdd(context);
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
