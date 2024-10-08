import 'dart:convert';

import '../core/http/http.dart';

import '../global/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/login_response.dart';
import '../models/user.dart';

class AuthService with ChangeNotifier {
  User user = User.fromJson({});
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  final _storage = const FlutterSecureStorage();

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  static Future<String?> getToken() async {
    return await const FlutterSecureStorage().read(key: 'token');
  }

  Future<LoginResponse> login(String email, String password) async {
    isLoading = true;

    final bodyContent = {'email': email, 'password': password};

    final res = await http.post(Uri.parse('${Environment.apiUrl}login'),
        body: jsonEncode(bodyContent),
        headers: {'Content-Type': 'application/json'});

    isLoading = false;
    final result = LoginResponse.fromJson(jsonDecode(res.body));

    if (result.ok) {
      user = result.user!;
      await _saveToken(result.token ?? '');
      return result;
    } else {
      return result;
    }
  }

  Future<LoginResponse> register(
      String name, String email, String password) async {
    isLoading = true;

    try {
      final data = {
        'name': name.trim(),
        'email': email.trim(),
        'password': password.trim(),
      };

      final res = await http.post(Uri.parse('${Environment.apiUrl}login/new'),
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});

      isLoading = false;

      final result = LoginResponse.fromJson(jsonDecode(res.body));

      if (result.ok) {
        user = result.user!;
        await _saveToken(result.token ?? '');
        return result;
      } else {
        return result;
      }
    } catch (e) {
      print('Error: $e');
      return LoginResponse(
        ok: false,
        msg: e.toString(),
      );
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    final res = await http.get(Uri.parse('${Environment.apiUrl}login/renew'),
        headers: {'x-token': '$token', 'Content-Type': 'application/json'});

    final result =
        ChatResponse<User>.fromJson(jsonDecode(res.body) ?? {}, (json) {
      return User.fromJson(json['user'] ?? {});
    });

    if (result.ok) {
      user = result.body!;
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _saveToken(String token) {
    return _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    return await _storage.delete(key: 'token');
  }
}
