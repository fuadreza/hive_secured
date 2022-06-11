
import 'dart:io';
import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_secured/service/secure_storage_service.dart';
import 'package:path_provider/path_provider.dart';

final HiveService hive = HiveService.instance;

class HiveService {
  static final HiveService _instance = HiveService();

  static HiveService get instance => _instance;

  static String keyItem = 'keyItem';

  Future<void> init() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocDirectory.path);
  }

  Future<void> saveData(String text) async {
    final Box box = await openBox('sampleBox');
    await box.put(keyItem, text);
    await box.close();
  }

  Future<String> loadData() async {
    final Box box = await openBox('sampleBox');
    final String data = await box.get(keyItem, defaultValue: '--');
    await box.close();
    return data;
  }

  Future<Box> openBox(String boxName) async {
    try {
      final Uint8List key = await secureStorageService.getEncryptionKey();
      final HiveCipher hiveCipher = HiveAesCipher(key);
      final Box box = await Hive.openBox(
        boxName,
        encryptionCipher: hiveCipher,
      );
      return box;
    } catch (error) {
      rethrow;
    }
  }

}