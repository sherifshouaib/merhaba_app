import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/utils/controllers/posts_controller.dart';

class NewPostProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _currentPostMode = "friends";
  String get currentPostMode => _currentPostMode;

  List<Map<String, dynamic>> _media = [];

  List<Map<String, dynamic>> get media => _media;

  int _currentPhotoIndex = 0;
  int get currentPhotoIndex => _currentPhotoIndex;

  Map<String, dynamic> _locationData = {};
  Map<String, dynamic> get locationData => _locationData;

  bool _isOccasionSelected = false;
  bool get isOccasionSelected => _isOccasionSelected;

  String _selectedOccasion = "graduation";
  String get selectedOccasion => _selectedOccasion;

  TextEditingController _textController = TextEditingController();
  TextEditingController get textController => _textController;

  Future<void> onAdd(BuildContext context) async {
    if (_textController.text == "") {
      return;
    }

    toggleLoading();
    try {
      var res = await PostsController.addPost({
        "content": jsonEncode({
          "text": _textController.text,
          "media": _media,
          "location": _locationData,
          "occasion": _selectedOccasion,
        }),
      });

      if (res["result"] == true) {
        Fluttertoast.showToast(msg: AppLocale.posted_label.getString(context));
      } else {
        Fluttertoast.showToast(
          msg: AppLocale.something_went_wrong_label.getString(context),
        );
      }
      GoRouter.of(context).pop();
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
        msg: AppLocale.something_went_wrong_label.getString(context),
      );
    }
    toggleLoading();
  }

  setIsOccasionSelected(bool value) {
    _isOccasionSelected = value;
    notifyListeners();
  }

  setSelectedOccasion(String value) {
    toggleLoading();
    try {
      _selectedOccasion = value;
      _isOccasionSelected = true;
      notifyListeners();
    } catch (e) {}

    toggleLoading();
  }

  setLocationData(Map<String, dynamic> value) {
    _locationData = value;

    notifyListeners();
  }

  setCurrentPhotoIndex(int value) {
    _currentPhotoIndex = value;
    notifyListeners();
  }

  addNewMedia(Map<String, dynamic> data) {
    _media.add(data);
    notifyListeners();
  }

  addNewMedias(List<Map<String, dynamic>> data) {
    _media.addAll(data);
    notifyListeners();
  }

  clearMedia() {
    _media.clear();
    notifyListeners();
  }

  setCurrentPostMode(String value) {
    _currentPostMode = value;
    notifyListeners();
  }

  getVisibilityOptions(BuildContext context) {
    final List<Map<String, dynamic>> list = [
      {
        'value': 'public',
        'label': AppLocale.public_label.getString(context),
        "icon": Icon(Icons.public),
      },
      {
        'value': 'friends',
        'label': AppLocale.friends_label.getString(context),
        "icon": Icon(Icons.group),
      },
      {
        'value': 'only_me',
        'label': AppLocale.only_me_label.getString(context),
        "icon": Icon(Icons.remove_red_eye),
      },
    ];
    return list;
  }

  getOccasionsOptions(BuildContext context) {
    final List<Map<String, dynamic>> list = [
      {
        'value': 'graduation',
        'label': AppLocale.graduation_label.getString(context),
        "icon": Icon(Icons.account_balance),
      },
      {
        'value': 'engagement',
        'label': AppLocale.engagement_label.getString(context),
        "icon": Icon(Icons.circle_outlined),
      },
      {
        'value': 'marriage',
        'label': AppLocale.marriage_label.getString(context),
        "icon": Icon(Icons.female),
      },
    ];
    return list;
  }

  toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}
