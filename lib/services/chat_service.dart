import 'dart:convert';

import '../models/message.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../core/http/domain/entities/payload.dart';
import '../global/environment.dart';

class ChatService with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  User userTo = User.fromJson({});

  Future<List<Message>> getChats(String userId) async {
    final token = await _storage.read(key: 'token');

    final res = await http.get(
      Uri.parse('${Environment.apiUrl}messages/$userId'),
      headers: {'x-token': '$token', 'Content-Type': 'application/json'},
    );

    final result = ChatResponse<List<Message>>.fromJson(
      jsonDecode(res.body),
      (json) {
        final messagesList = json['messages'] as List<dynamic>;
        return messagesList
            .map((messageJson) => Message.fromJson(messageJson))
            .toList();
      },
    );

    if (result.ok) {
      return result.body ?? [];
    }
    return [];
  }
}
