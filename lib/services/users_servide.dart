import 'dart:convert';

import '../core/http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../global/environment.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class UsersService {
  final _storage = const FlutterSecureStorage();

  Future<List<User>> getUsers() async {
    final token = await _storage.read(key: 'token');

    final res = await http.get(
      Uri.parse('${Environment.apiUrl}users'),
      headers: {'x-token': '$token', 'Content-Type': 'application/json'},
    );

    final result = ChatResponse<List<User>>.fromJson(
      jsonDecode(res.body),
      (json) {
        final usersList = json['users'] as List<dynamic>;
        return usersList.map((userJson) => User.fromJson(userJson)).toList();
      },
    );

    if (result.ok) {
      return result.body ?? [];
    } else {
      throw Exception(result.errorMsg ?? 'Failed to fetch users');
    }
  }
}
