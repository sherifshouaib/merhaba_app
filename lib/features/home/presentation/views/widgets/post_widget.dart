import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:merhaba/core/helper/spacing.dart';
import 'package:merhaba/features/profile/presentation/views/widgets/custom_profile_photo.dart';
import 'package:video_player/video_player.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key, required this.post});

  final Map<String, dynamic> post;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  CarouselSliderController _controller = CarouselSliderController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width - 25,

                //  height: 400,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomProfilePhoto(
                              post: widget.post,
                              height: 30,
                              width: 30,
                            ),
                            horizontalSpace(15),
                            SizedBox(
                              width:
                                  (MediaQuery.sizeOf(context).width - 65) * 0.4,

                              child: Text(
                                widget.post["username"].toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_horiz),
                        ),
                      ],
                    ),
                    verticalSpace(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: (MediaQuery.sizeOf(context).width - 20) * 0.9,
                          child: Text(
                            widget.post["parsedContent"]["text"].toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(5),

                    widget.post["parsedContent"]["media"].toString() == "" ||
                            widget.post["parsedContent"]["media"].isEmpty
                        ? Container()
                        : CarouselSlider(
                            items: (widget.post["parsedContent"]["media"] as List)
                                .map(
                                  (item) => item["type"] == "photo"
                                      ? CachedNetworkImage(
                                          imageUrl: item["url"].toString(),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Center(child: Icon(Icons.error)),
                                        )
                                      : Container(
                                          child: FlickVideoPlayer(
                                            flickManager: FlickManager(
                                              videoPlayerController:
                                                  VideoPlayerController.networkUrl(
                                                    Uri.parse(
                                                      item["url"].toString(),
                                                    ),
                                                  ),
                                            ),
                                          ),
                                        ),
                                )
                                .toList(),
                            carouselController: _controller,
                            options: CarouselOptions(
                              autoPlay: false,
                              enlargeCenterPage: false,
                              aspectRatio: 2.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentIndex = index;
                                });

                                //  newPostProvider.setCurrentPhotoIndex(index);
                              },
                              viewportFraction: 1.0,
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: (widget.post["parsedContent"]["media"] as List)
                          .asMap()
                          .entries
                          .map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 12.0,
                                height: 12.0,
                                margin: EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black)
                                          .withValues(
                                            alpha: currentIndex == entry.key
                                                ? 0.9
                                                : 0.4,
                                          ),
                                ),
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
        ],
      ),
    );
  }
}
