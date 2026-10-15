import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  Future<void> write({required String key, required String value});
  Future<String?> read({required String key});
  Future<void> delete({required String key});
  Future<void> deleteAll();
}

class FlutterSecureStorageService implements SecureStorage {
  FlutterSecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  @override
  Future<void> delete({required String key}) {
    return _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() {
    return _storage.deleteAll();
  }

  @override
  Future<String?> read({required String key}) {
    return _storage.read(key: key);
  }

  @override
  Future<void> write({required String key, required String value}) {
    return _storage.write(key: key, value: value);
  }
}

class InMemorySecureStorage implements SecureStorage {
  final Map<String, String> _memoryStore = <String, String>{};

  @override
  Future<void> delete({required String key}) async {
    _memoryStore.remove(key);
  }

  @override
  Future<void> deleteAll() async {
    _memoryStore.clear();
  }

  @override
  Future<String?> read({required String key}) async {
    return _memoryStore[key];
  }

  @override
  Future<void> write({required String key, required String value}) async {
    _memoryStore[key] = value;
  }
}
