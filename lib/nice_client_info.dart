library nice_client_info;

import 'dart:async';

import 'package:package_info_plus/package_info_plus.dart';

import 'models/nice_client_info_model.dart';

import 'services/device_info/device_info_service.dart';

export 'package:device_info_plus/device_info_plus.dart';
export 'package:package_info_plus/package_info_plus.dart';

export 'models/nice_client_info_model.dart';

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

  Future<NiceClientInfoPlugin> setup() async {
    final deviceInfo = DeviceInfoService();
    final result = await Future.wait(
      [
        deviceInfo.getSimplifyDeviceInfo(),
        PackageInfo.fromPlatform(),
      ],
    );

    if (result.isNotEmpty) {
      final simplifyDeviceInfo = result[0] as SimplifyDeviceInfo;
      final pInfo = result[1] as PackageInfo;

      final appVersionName = pInfo.version;
      final appVersionCode = pInfo.buildNumber;
      final appName = pInfo.appName;
      final packageName = pInfo.packageName;

      _info = NiceClientInfo(
        model: simplifyDeviceInfo.model,
        osversion: simplifyDeviceInfo.osversion,
        appVersionName: appVersionName,
        appVersionCode: appVersionCode,
        appName: appName,
        packageName: packageName,
      );
    }
    return this;
  }
}
