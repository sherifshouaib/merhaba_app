import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:merhaba/core/locale/app_locale.dart';

class NewPostProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _currentPostMode = "friends";
  String get currentPostMode => _currentPostMode;

  List<Map<String, dynamic>> _photos = [];

  List<Map<String, dynamic>> get photos => _photos;

  addNewPhoto(Map<String, dynamic> data) {
    _photos.add(data);
    notifyListeners();
  }

  addNewPhotos(List<Map<String, dynamic>> data) {
    _photos.addAll(data);
    notifyListeners();
  }

  clearPhotos() {
    _photos.clear();
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
