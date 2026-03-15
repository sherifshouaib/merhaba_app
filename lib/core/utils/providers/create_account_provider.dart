import 'package:flutter/cupertino.dart';

class CreateAccountProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}