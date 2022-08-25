import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static const CREDIT_CARD_KEY = "CREDIT_CARD";

  static String _getUserCardKey(int id) => "$CREDIT_CARD_KEY/$id";

  static Future<void> saveCardNumber(int id, String card) async {
    await _storage.write(key: _getUserCardKey(id), value: card);
  }

  static Future<String?> getCardNumber(int id) async {
    return await _storage.read(key: _getUserCardKey(id));
  }

  static Future<void> removeCardNumber(int id) async {
    await _storage.delete(key: _getUserCardKey(id));
  }
}
