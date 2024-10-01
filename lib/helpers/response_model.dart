// class CustomResponse<T> {
//   final bool ok;
//   final String msg;
//   final String? errorMsg;
//   final T? data;

//   CustomResponse({
//     required this.ok,
//     required this.msg,
//     this.errorMsg,
//     this.data,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'ok': ok,
//       'msg': msg,
//       'errorMsg': errorMsg,
//       'data': data,
//     };
//   }

//   static CustomResponse<T> fromMap<T>(
//     Map<String, dynamic> json,
//     T Function(Map<String, dynamic>) fromJson,
//   ) {
//     return CustomResponse<T>(
//       ok: json['ok'] ?? false,
//       msg: json['msg'] ?? '',
//       errorMsg: json['errorMsg'] ?? '',
//       data: json['data'] != null ? fromJson(json['data']) : null,
//     );
//   }
// }
