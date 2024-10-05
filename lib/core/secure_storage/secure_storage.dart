import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage{
  SecureStorage._();
  /// Set Secure String with [key]
  static Future<void> setSecureString(String key, dynamic value) async {
    const flutterSecureStorage =  FlutterSecureStorage();
    await flutterSecureStorage.write(key: key, value: value);
  }

  /// get Secure String with [key]
  static Future<String> getSecureString(String value) async {
    const flutterSecureStorage = FlutterSecureStorage();
   return await flutterSecureStorage.read(key: value)??'';
  }

  /// Delete Secure String with [key]
  static Future<void> deleteSecureString(String key) async {
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.delete(key: key);
  }
}
