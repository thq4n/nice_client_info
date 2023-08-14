import 'package:flutter/foundation.dart';

import '../services/keychain/keychain_service_unsupported.dart'
    if (dart.library.io) '../services/keychain/keychain_service.dart'
    if (dart.library.html) '../services/keychain/keychain_service_unsupported.dart';

class KeyChainUtil {
  static Future<String?> getStorageDeviceId({
    required String packageName,
    bool enableKeyChainStorage = true,
  }) async {
    if (!enableKeyChainStorage) {
      return null;
    }
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android) {
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
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android) {
      return KeychainService.setDeviceId(packageName, identifier);
    }
    return Future.value(false);
  }
}
