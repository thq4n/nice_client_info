class NiceClientInfo {
  /// DEVICE-INFO

  /// device osversion
  final String model;

  /// device osversion
  final String osversion;

  /// unique device identifier
  final String identifier;

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
    required this.identifier,
    required this.appVersionName,
    required this.appVersionCode,
    required this.appName,
    required this.packageName,
  });

  // like 1.0.0(1)
  String get appVersion => '$appVersionName($appVersionCode)';
}
