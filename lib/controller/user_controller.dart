import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modal/user_modal.dart';

class UserController extends ChangeNotifier {
  List<UserModal> user = [];
  late bool isPasswordVisible;
  late bool isConfirmPasswordVisible;
  Logger l = Logger();
  String? username;
  String? email;
  double? total;
  Uint8List? image;

  UserController() {
    init();

    isPasswordVisible = false;
    isConfirmPasswordVisible = false;
  }

  init() async {
    username = await getStoredUsername();
    email = await getStoredEmail();
    image = await getStoredImage();
    total = await getStoredTotal();
    notifyListeners();
  }

  Future<String?> getStoredUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('username');
  }

  Future<String?> getStoredEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('email');
  }

  Future<Uint8List?> getStoredImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? encodedImage = prefs.getString('image');

    if (encodedImage != null) {
      Uint8List decodedImage = base64.decode(encodedImage);
      return decodedImage;
    } else {
      return null;
    }
  }

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('balance');
    await prefs.remove('image');
    await prefs.remove('email');
  }

  Future<double?> getStoredTotal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getDouble('balance');
  }

  togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }
}
