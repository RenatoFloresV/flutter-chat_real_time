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

  factory ChatResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? dataParser,
  ) {
    return ChatResponse<T>(
      ok: json['ok'] ?? false,
      msg: json['msg'] ?? 'No message provided',
      errorMsg: json['errorMsg'],
      body: dataParser != null ? dataParser(json) : null,
    );
  }
}
