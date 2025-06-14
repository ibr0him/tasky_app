import 'package:flutter/material.dart';

import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';

class UserController extends ChangeNotifier {
  String? username;
  String? motivationQuote;
  String? userImagePath;

  Future<void> loadUserData() async {
    username = PreferencesManager().getString(StorageKey.username);
    motivationQuote = PreferencesManager().getString(StorageKey.motivationQuote);
    userImagePath = PreferencesManager().getString(StorageKey.userImage);
    notifyListeners();
  }

  Future<void> updateUserData({
    required String username,
    required String motivationQuote,
  }) async {
    await PreferencesManager().setString(StorageKey.username, username);
    await PreferencesManager().setString(StorageKey.motivationQuote, motivationQuote);
    this.username = username;
    this.motivationQuote = motivationQuote;
    notifyListeners();
  }

  Future<void> updateUserImage(String imagePath) async {
    await PreferencesManager().setString(StorageKey.userImage, imagePath);
    userImagePath = imagePath;
    notifyListeners();
  }

  Future<void> clearUserData() async {
    await PreferencesManager().remove(StorageKey.username);
    await PreferencesManager().remove(StorageKey.motivationQuote);
    await PreferencesManager().remove(StorageKey.userImage);
    username = null;
    motivationQuote = null;
    userImagePath = null;
    notifyListeners();
  }
}
