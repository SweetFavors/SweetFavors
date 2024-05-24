import 'package:flutter/material.dart';

class TokenProvider extends ChangeNotifier {
  String? _token;
  int? _userId;

  String? get token => _token;
  int? get userId => _userId;

  void setToken(String token, int userId) {
    _token = token;
    _userId = userId;
    notifyListeners();
  }
}
