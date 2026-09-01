import 'package:hive_flutter/hive_flutter.dart';

/// Generic NoSQL key-value & document caching service using [Hive].
class HiveStorageService {
  /// Initializes Hive database engine for Flutter apps
  static Future<void> init() async {
    await Hive.initFlutter();
  }

  /// Opens a named Hive Box (collection)
  Future<Box<T>> openBox<T>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<T>(boxName);
    }
    return await Hive.openBox<T>(boxName);
  }

  /// Writes an object or JSON map to a specific Box
  Future<void> put<T>(String boxName, String key, T value) async {
    final box = await openBox<T>(boxName);
    await box.put(key, value);
  }

  /// Reads an object or JSON map from a specific Box
  Future<T?> get<T>(String boxName, String key) async {
    final box = await openBox<T>(boxName);
    return box.get(key);
  }

  /// Deletes a key from a Box
  Future<void> delete<T>(String boxName, String key) async {
    final box = await openBox<T>(boxName);
    await box.delete(key);
  }

  /// Clears all entries from a specific Box
  Future<void> clearBox<T>(String boxName) async {
    final box = await openBox<T>(boxName);
    await box.clear();
  }
}
