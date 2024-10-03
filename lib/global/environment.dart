import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid
      ? 'http://10.0.2.2:3000/api/' // Para Android Emulator
      : 'http://192.168.1.38:3000/api/'; // IP de tu Mac para iOS físico

  static String socketUrl = Platform.isAndroid
      ? 'http://10.0.2.2:3000'
      : 'http://192.168.1.38:3000'; // IP de tu Mac
}
