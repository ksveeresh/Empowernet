import 'dart:convert';

import 'package:encrypt/encrypt.dart';
class EncryptModel{
  Encryptedata(var s){
    final key = Key.fromLength(32);
    final iv = IV.fromLength(8);
    final encrypter = Encrypter(Salsa20(key));
    return encrypter.encrypt(s, iv: iv).base64;
  }
  Decryptedata(var s){
    final key = Key.fromLength(32);
    final iv = IV.fromLength(8);
    final encrypter = Encrypter(Salsa20(key));
    return encrypter.decrypt(Encrypted.fromBase64(s), iv: iv);
  }
}