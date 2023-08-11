import 'package:flutter_keychain/flutter_keychain.dart';

class KeychainService {
  static Future<String?> getDeviceId(String packageName) {
    return FlutterKeychain.get(key: '${packageName}_device_id');
  }

  static Future setDeviceId(String packageName, String deviceId) {
    return FlutterKeychain.put(
      key: '${packageName}_device_id',
      value: deviceId,
    );
  }
}
