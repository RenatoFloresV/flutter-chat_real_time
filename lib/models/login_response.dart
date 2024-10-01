import 'dart:convert';

import 'user.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool ok;
  String msg;
  String? errorMsg;
  User? user;
  String? token;

  LoginResponse({
    required this.ok,
    required this.msg,
    this.errorMsg,
    this.user,
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"] ?? false,
        msg: json["msg"] ?? '',
        errorMsg: json["errorMsg"] ?? '',
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        token: json["token"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "errorMsg": errorMsg,
        "user": user?.toJson(),
        "token": token,
      };
}
