// import 'dart:io';

// import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
// import '../../domain/entities/entities.dart';
// import 'package:dio/dio.dart';
// import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
// import 'package:fpdart/fpdart.dart';

// import '../../domain/repository.dart';

// /// AsapDio

// class ChatDioHttp extends ChatHttp {
//   ChatDioHttp({
//     Dio? dioInstance,
//     String? baseUrl,
//     this.appName = 'Chat',
//     List<Interceptor> interceptors = const [],
//     this.appVersion = '',
//     this.countryCode = 'ES',
//     this.langCode = 'es',
//     this.os = '',
//     this.userAgent = '',
//     this.transactionId = '',
//     this.deviceVersion = '',
//     this.deviceUuid = '',
//     this.aditionalHeaders = const {},
//     this.enableLogs = true,
//     this.enableSentry = true,
//   }) {
//     _dioInstance = (dioInstance ?? Dio())
//       ..options.baseUrl =
//           baseUrl ?? const String.fromEnvironment('BASE_URL_PRODUCTION')
//       ..options.followRedirects = false
//       ..options.connectTimeout = const Duration(seconds: 25)
//       ..options.receiveTimeout = const Duration(seconds: 25)
//       ..interceptors.addAll(
//         interceptors,
//       );

//     _addDefaultHeaders();
//     _addCacheInterceptor();
//     _addLogInterceptor();
//   }

//   late Dio _dioInstance;

//   /// This property is a value in Http request headers.
//   ///
//   /// `X-App-Name`
//   String appName;

//   /// This property is a value in Http request headers.
//   ///
//   /// `X-App-Version`
//   String appVersion;

//   /// This property is a value in Http request headers.
//   ///
//   /// `X-Country`
//   String countryCode;

//   /// This property is a value in Http request headers.
//   ///
//   /// `X-Lang`
//   String langCode;

//   /// This property is a value in Http request headers.
//   ///
//   /// `os`
//   String os;

//   /// This property is a value in Http request headers.
//   ///
//   /// `User-Agent`
//   String userAgent;

//   /// This property is a value in Http request headers.
//   ///
//   /// `X-Device-Version`
//   String deviceVersion;

//   /// This property is a value in Http request headers.
//   ///
//   /// `X-Transaction-ID`
//   String transactionId;

//   /// This property is a value in Http request headers.
//   ///
//   /// `X-Device-Uuid`
//   String deviceUuid;

//   /// It's used to add new headers, by default all tul api necesary headers
//   /// was added, but if you need to add another one, you can
//   /// By default this property is a empty `Map<String, String>`
//   ///
//   Map<String, dynamic> aditionalHeaders;

//   /// If is `true` should add LogInterceptor in
//   /// the interceptor list .
//   ///
//   ///  ```dart
//   ///   LogInterceptor(
//   ///      requestBody: true,
//   ///      responseBody: true,
//   ///    )
//   ///  ```
//   bool enableLogs;

//   bool enableSentry;

//   /// a dios instance for this class
//   Dio get dio => _dioInstance;

//   ///This method add new headers to `Http request headers`
//   ///
//   /// Be careful because this class does not remove headers after they are added
//   void addHeaders(Map<String, dynamic>? headers) {
//     if (headers == null) return;
//     _dioInstance.options.headers.addAll(headers);
//   }

//   /// This method update an `Http request headers` value
//   ///
//   /// if  an `Http request headers` value whit the key does not exist, the
//   /// methods will return
//   void updateHeader(String key, String value) {
//     _dioInstance.options.headers.update(key, (_) => value);
//   }

//   ///This method add new headers to `Http request headers`
//   void setAuthToken(String token) {
//     // if (token.isEmpty) {
//     //   _dioInstance.options.headers.remove('Authorization');
//     //   return;
//     // }

//     // if (_dioInstance.options.headers['Authorization'] == null) {
//     //   _dioInstance.options.headers.addAll({
//     //     'Authorization': 'Bearer $token',
//     //   });
//     // } else {
//     //   _dioInstance.options.headers.update(
//     //     'Authorization',
//     //     (v) => 'Bearer $token',
//     //   );
//     // }
//   }

//   ///This method update the country value in `Http request headers`
//   void updateCountry(String countryCode) {
//     _dioInstance.options.headers.update('X-Country', (v) => countryCode);
//   }

//   void _addDefaultHeaders() {
//     _dioInstance.options.headers = {
//       Headers.contentTypeHeader: Headers.jsonContentType,
//       Headers.acceptHeader: Headers.jsonContentType,
//       HttpHeaders.acceptEncodingHeader: 'gzip',
//       'os': os,
//       'App-name': appName,
//       'App-version': appVersion,
//       'User-Agent': userAgent,
//       'device-uuid': deviceUuid,
//       'X-App-Name': appName,
//       'X-Country': countryCode,
//       'X-Lang': langCode,
//       'X-App-Version': appVersion,
//       'X-Device-Version': deviceVersion,
//       'X-Transaction-ID': transactionId,
//       'X-Device-Uuid': deviceUuid,
//       'X-Policy-Version': 1,
//       ...aditionalHeaders
//     };
//   }

//   void removeHeader(String header) {
//     _dioInstance.options.headers.remove(header);
//   }

//   @override
//   Future<Either<ChatResponseError, ChatResponse<T>>> get<T>(
//     String url, {
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     try {
//       // setAuthToken(storage.accessToken);

//       final res = await dio.get<T>(
//         url,
//         queryParameters: queryParameters,
//       );

//       return Either.of(_copyResponse<T>(res));
//     } on DioException catch (e) {
//       return Either.left(
//         ChatResponseError(
//           code: e.response?.statusCode ?? -1,
//           message: e.message ?? '',
//         ),
//       );
//     }
//   }

//   @override
//   Future<Either<ChatResponseError, ChatResponse<T>>> patch<T>(
//     String url, {
//     Map<String, dynamic>? queryParameters,
//     body,
//   }) async {
//     try {
//       // setAuthToken(storage.accessToken);

//       final res = await dio.patch(
//         url,
//         data: body,
//         queryParameters: queryParameters,
//       );

//       return Either.of(_copyResponse<T>(res));
//     } on DioException catch (e) {
//       return Either.left(
//         ChatResponseError(
//           code: e.response?.statusCode ?? -1,
//           message: e.message ?? '',
//         ),
//       );
//     }
//   }

//   @override
//   Future<Either<ChatResponseError, ChatResponse<T>>> post<T>(
//     String url, {
//     Map<String, dynamic>? queryParameters,
//     Object? body,
//     Map<String, dynamic>? headers,
//   }) async {
//     try {
//       // setAuthToken(storage.accessToken);

//       final res = await dio.post<T>(
//         url,
//         data: body,
//         queryParameters: queryParameters,
//       );

//       return Either.of(_copyResponse<T>(res));
//     } on DioException catch (e) {
//       return Either.left(
//         ChatResponseError(
//           code: e.response?.statusCode ?? -1,
//           message: e.message ?? '',
//         ),
//       );
//     }
//   }

//   @override
//   Future<Either<ChatResponseError, ChatResponse<T>>> put<T>(
//     String url, {
//     Map<String, dynamic>? queryParameters,
//     body,
//   }) async {
//     try {
//       // setAuthToken(storage.accessToken);

//       final res = await dio.put(
//         url,
//         data: body,
//         queryParameters: queryParameters,
//       );

//       return Either.of(_copyResponse<T>(res));
//     } on DioException catch (e) {
//       return Either.left(
//         ChatResponseError(
//           code: e.response?.statusCode ?? -1,
//           message: e.message ?? '',
//         ),
//       );
//     }
//   }

//   @override
//   Future<Either<ChatResponseError, ChatResponse<T>>> delete<T>(
//       String url) async {
//     try {
//       // setAuthToken(storage.accessToken);

//       final res = await dio.delete(url);

//       return Either.of(_copyResponse<T>(res));
//     } on DioException catch (e) {
//       return Either.left(
//         ChatResponseError(
//           code: e.response?.statusCode ?? -1,
//           message: e.message ?? '',
//         ),
//       );
//     }
//   }

//   /// _addCacheInterceptor
//   /// add a dio ache interceptor by default
//   void _addCacheInterceptor() {
//     CacheOptions cacheOptions = CacheOptions(
//       store: MemCacheStore(),
//       maxStale: const Duration(days: 7),
//       allowPostMethod: false,
//       hitCacheOnErrorExcept: [401, 403, 405, 500, 404],
//     );

//     _dioInstance.interceptors.add(
//       DioCacheInterceptor(options: cacheOptions),
//     );
//   }

//   void _addLogInterceptor() {
//     if (!enableLogs) return;

//     _dioInstance.interceptors.add(
//       AwesomeDioInterceptor(
//         logRequestTimeout: false,
//         logRequestHeaders: true,
//         logResponseHeaders: false,
//       ),
//     );
//   }

//   // ChatResponse<T> _copyResponse<T>(Response? response) {
//   //   try {
//   //     // return ChatResponse<T>.fromJson(response?.data,);
//   //   } catch (e) {
//   //     rethrow;
//   //   }
//   // }
// }
