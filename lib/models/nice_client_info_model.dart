import 'dart:convert';

class NiceClientInfo {
  /// DEVICE-INFO

  /// device osversion
  final String model;

  /// device osversion
  final String osversion;

  /// APP-INFO

  /// build name
  final String appVersionName;

  /// build number
  final String appVersionCode;

  /// appname
  final String appName;

  /// app package name
  final String packageName;

  NiceClientInfo({
    required this.model,
    required this.osversion,
    required this.appVersionName,
    required this.appVersionCode,
    required this.appName,
    required this.packageName,
  });

  // like 1.0.0(1)
  String get appVersion => '$appVersionName($appVersionCode)';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model,
      'osversion': osversion,
      'appVersionName': appVersionName,
      'appVersionCode': appVersionCode,
      'appName': appName,
      'packageName': packageName,
    };
  }

  factory NiceClientInfo.fromMap(Map<String, dynamic> map) {
    return NiceClientInfo(
      model: map['model'] as String,
      osversion: map['osversion'] as String,
      appVersionName: map['appVersionName'] as String,
      appVersionCode: map['appVersionCode'] as String,
      appName: map['appName'] as String,
      packageName: map['packageName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NiceClientInfo.fromJson(String source) =>
      NiceClientInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
