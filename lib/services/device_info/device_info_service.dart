import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceInfoService {
  Future<SimplifyDeviceInfo> getSimplifyDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (kIsWeb) {
        return _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      } else {
        return switch (defaultTargetPlatform) {
          TargetPlatform.android =>
            _readAndroidBuildData(await deviceInfoPlugin.androidInfo),
          TargetPlatform.iOS =>
            _readIosDeviceInfo(await deviceInfoPlugin.iosInfo),
          TargetPlatform.linux =>
            _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo),
          TargetPlatform.windows =>
            _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo),
          TargetPlatform.macOS =>
            _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo),
          TargetPlatform.fuchsia => SimplifyDeviceInfo(
              model: 'Fuchsia platform isn\'t supported',
              osversion: 'Fuchsia platform isn\'t supported',
              identifier: 'Fuchsia platform isn\'t supported',
            ),
        };
      }
    } catch (e, stackTrace) {
      log('''e: $e,
stackTrace: $stackTrace''');
      return SimplifyDeviceInfo(
        model: 'unkown',
        osversion: 'unkown',
        identifier: 'unkown',
      );
    }
  }

  SimplifyDeviceInfo _readAndroidBuildData(AndroidDeviceInfo build) {
    return SimplifyDeviceInfo(
      model: '${build.manufacturer} ${build.model}',
      osversion: build.version.release,
      identifier: build.id,
    );
  }

  SimplifyDeviceInfo _readIosDeviceInfo(IosDeviceInfo data) {
    return SimplifyDeviceInfo(
      model: data.utsname.machine,
      osversion: data.systemVersion,
      identifier: data.identifierForVendor,
    );
  }

  SimplifyDeviceInfo _readLinuxDeviceInfo(LinuxDeviceInfo data) {
    return SimplifyDeviceInfo(
      model: data.name,
      osversion: data.version ?? '',
      identifier: data.buildId,
    );
  }

  SimplifyDeviceInfo _readWebBrowserInfo(WebBrowserInfo data) {
    return SimplifyDeviceInfo(
      model: describeEnum(data.browserName),
      osversion: data.userAgent ?? '',
      identifier: null,
    );
  }

  SimplifyDeviceInfo _readMacOsDeviceInfo(MacOsDeviceInfo data) {
    return SimplifyDeviceInfo(
      model: data.model,
      osversion:
          '''Kenel:${data.kernelVersion} - Major:${data.majorVersion} - Minor:${data.minorVersion} - Patch:${data.patchVersion}''',
      identifier: null,
    );
  }

  SimplifyDeviceInfo _readWindowsDeviceInfo(WindowsDeviceInfo data) {
    return SimplifyDeviceInfo(
      model: data.computerName,
      osversion:
          '''Major:${data.majorVersion} - Minor:${data.minorVersion} - BuildNumber:${data.buildNumber}''',
      identifier: data.deviceId,
    );
  }
}

class SimplifyDeviceInfo {
  final String model;
  final String osversion;
  final String? identifier;

  SimplifyDeviceInfo({
    required this.model,
    required this.osversion,
    required this.identifier,
  });
}
