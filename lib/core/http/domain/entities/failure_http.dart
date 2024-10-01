import 'package:equatable/equatable.dart';

class ChatResponseError extends Equatable {
  const ChatResponseError({
    this.message = '',
    this.code = -1,
  });

  final String message;
  final int code;

  factory ChatResponseError.fromJson(Map<String, dynamic> data) {
    return ChatResponseError(
      code: data['code'] ?? -1,
      message: data['message'] ?? '',
    );
  }

  @override
  List<Object?> get props => [message, code];
}
