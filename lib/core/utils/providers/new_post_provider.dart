import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/locale/app_locale.dart';

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

  toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}
