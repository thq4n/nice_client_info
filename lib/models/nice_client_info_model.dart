class NiceClientInfo {
  //device info
  final String model;
  final String osversion;
  final String identifier;

  //app info

  final String appVersionName;
  final String appVersionCode;
  final String appName;
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

  String get appVersion => '$appVersionName($appVersionCode)';
}
