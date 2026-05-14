import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/helper/spacing.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/utils/providers/post_provider.dart';
import 'package:merhaba/features/home/presentation/views/widgets/post_widget.dart';
import 'package:merhaba/main_development.dart';
import 'package:provider/provider.dart';

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
            // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),

            // shrinkWrap: true,
            // physics: ClampingScrollPhysics(),
            children: [
              PostWidget(
                post: postProvider.currentPost,
                showActions: true,
                canNavigate: false,
              ),
              verticalSpace(10),

              // Comments here
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
                    color: Colors.blueGrey.withOpacity(0.25),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      IconButton(icon: Icon(Icons.add), onPressed: () {}),

                      Expanded(
                        child: fluent.TextBox(
                          placeholder: AppLocale.comment_label.getString(
                            context,
                          ),
                          expands: false,
                          controller: postProvider.newCommentController,
                          focusNode: postProvider.newCommentFocusNode,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.photo_camera_outlined),
                        onPressed: () {},
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
