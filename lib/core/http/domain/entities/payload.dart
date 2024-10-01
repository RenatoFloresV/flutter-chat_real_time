class ChatResponse<T> {
  final bool ok;
  final String msg;
  final String? errorMsg;
  final T? body;

  ChatResponse({
    required this.ok,
    required this.msg,
    this.errorMsg,
    this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'ok': ok,
      'msg': msg,
      'errorMsg': errorMsg,
      'body': body,
    };
  }

  static ChatResponse<T> fromMap<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return ChatResponse<T>(
      ok: json['ok'] ?? false,
      msg: json['msg'] ?? '',
      errorMsg: json['errorMsg'] ?? '',
      body: json['body'] != null ? fromJson(json['body']) : null,
    );
  }

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse<T>(
      ok: json['ok'] ?? false,
      msg: json['msg'] ?? '',
      errorMsg: json['errorMsg'] ?? '',
      body: json['body'] ?? {},
    );
  }
}
