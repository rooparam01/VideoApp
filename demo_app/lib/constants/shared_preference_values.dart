import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ValueStore {
  static const storage = FlutterSecureStorage();

  static Future<void> setisLogin(String value) async {
    await storage.write(key: 'isLoggedin', value: value);
  }

  static Future<String?> getisLogin() async {
    return await storage.read(key: 'isLoggedin');
  }

}