import 'dart:io';

import '../services/keychain_service_unsupported.dart'
    if (dart.library.io) '../services/keychain_service.dart'
    if (dart.library.html) '../services/keychain_service_unsupported.dart';

class KeyChainUtil {
  static Future<String?> getStorageDeviceId({
    required String packageName,
    bool enableKeyChainStorage = true,
  }) async {
    if (!enableKeyChainStorage) {
      return null;
    }
    if (Platform.isAndroid || Platform.isIOS) {
      return KeychainService.getDeviceId(packageName);
    }
    return null;
  }

  static Future<dynamic> storageDeviceId({
    required String packageName,
    bool enableKeyChainStorage = true,
    required String identifier,
  }) {
    if (!enableKeyChainStorage) {
      return Future.value(false);
    }
    if (Platform.isAndroid || Platform.isIOS) {
      return KeychainService.setDeviceId(packageName, identifier);
    }
    return Future.value(false);
  }
}
