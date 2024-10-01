import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid
      ? 'https://10.0.2.2:3000/api/'
      : 'http://localhost:3000/api/';

  static String socketUrl =
      Platform.isAndroid ? 'https://10.0.2.2:3000' : 'http://localhost:3000';
}
