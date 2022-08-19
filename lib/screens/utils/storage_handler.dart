import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create storage
const flutterStorage = FlutterSecureStorage();

Future<void> writeStorage(key, value) async {
  await flutterStorage.write(key: key, value: value);
}

Future readStorage(key) async {
  return await flutterStorage.read(key: key);
}

Future<bool> checkTokenExistsInStorage() async {
  try {
    String? token = await flutterStorage.read(key: 'access_token');
    return token != null ? true: false;
  }catch(e){
    debugPrint('Error: $e');
  }
  return false;
}