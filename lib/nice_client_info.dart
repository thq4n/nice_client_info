library nice_client_info;

import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

import 'models/nice_client_info_model.dart';

import 'utils/keychain_utils.dart';

export 'package:device_info/device_info.dart';
export 'package:package_info/package_info.dart';

export 'models/nice_client_info_model.dart';

/// A Calculator.
class NiceClientInfoPlugin {
  static final NiceClientInfoPlugin instance = NiceClientInfoPlugin._();

  NiceClientInfo? _info;

  NiceClientInfo get info {
    assert(
      _info != null,
      'Please run NiceClientInfoPlugin.instance.setup()',
    );
    return _info!;
  }

  NiceClientInfoPlugin._();

  Future<NiceClientInfoPlugin> setup({
    bool enableKeyChainStorage = true,
  }) async {
    final deviceInfo = DeviceInfoPlugin();
    final result = await Future.wait([
      if (Platform.isAndroid) deviceInfo.androidInfo,
      if (Platform.isIOS) deviceInfo.iosInfo,
      PackageInfo.fromPlatform()
    ]);

    if (result.isNotEmpty) {
      String model;
      String osversion;
      String identifier;

      final pInfo = result[1] as PackageInfo;

      final appVersionName = pInfo.version;
      final appVersionCode = pInfo.buildNumber;
      final appName = pInfo.appName;
      final packageName = pInfo.packageName;

      final storageDeviceId = await KeyChainUtil.getStorageDeviceId(
        packageName: packageName,
        enableKeyChainStorage: enableKeyChainStorage,
      );

      if (Platform.isAndroid) {
        final androidInfo = result[0] as AndroidDeviceInfo;
        model = '${androidInfo.manufacturer} ${androidInfo.model}';
        osversion = androidInfo.version.release;
        identifier = storageDeviceId ?? androidInfo.androidId;
      } else {
        final iosInfo = result[0] as IosDeviceInfo;
        model = iosInfo.utsname.machine;
        osversion = iosInfo.systemVersion;
        identifier = storageDeviceId ?? iosInfo.identifierForVendor;
      }

      unawaited(
        KeyChainUtil.storageDeviceId(
          packageName: packageName,
          enableKeyChainStorage: enableKeyChainStorage,
          identifier: identifier,
        ),
      );

      _info = NiceClientInfo(
        model: model,
        osversion: osversion,
        identifier: identifier,
        appVersionName: appVersionName,
        appVersionCode: appVersionCode,
        appName: appName,
        packageName: packageName,
      );
    }
    return this;
  }
}
