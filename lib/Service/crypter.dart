import 'package:encrypt/encrypt.dart';
import 'dart:convert';

import '../env.dart' as env;

void generateKey(String usr, String pass) {
  var bytes = utf8.encode((usr + env.authHash).substring(1, 17));
  var base64str = base64.encode(bytes);

  env.cryptKey = base64str;
}

String encrypt(String text) {
  final key = Key.fromBase64(env.cryptKey);
  final iv = IV.fromBase64(env.ivBase64);

  final encrypter = Encrypter(AES(key));

  final encryptedText = encrypter.encrypt(text, iv: iv);
  return encryptedText.base64;
}

String decrypt(String text) {
  final key = Key.fromBase64(env.cryptKey);
  final iv = IV.fromBase64(env.ivBase64);

  final encrypter = Encrypter(AES(key));

  final decryptedText = encrypter.decrypt64(text, iv: iv);
  return decryptedText;
}
