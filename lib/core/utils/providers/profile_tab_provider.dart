import 'package:flutter/material.dart';

class ProfileTabProvider with ChangeNotifier {
  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  final String _photoUrl = "";
  String get photoUrl => _photoUrl;

  final String _email = "sherifshouaib22@gmail.com";
  String get email => _email;

  final String _username = "sherif shouaib";
  String get username => _username;

  final String _phone = "01011804716";
  String get phone => _phone;
}
