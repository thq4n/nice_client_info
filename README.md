## Usage

Add `nice_client_info` as a dependency in your pubspec.yaml file.

### Example

```dart
// Import package
import 'package:nice_client_info/nice_client_info.dart';

// Instantiate it
final plugin = await NiceClientInfoPlugin.instance.setup();

// Information
print(plugin.info.model);
print(plugin.info.osversion);
print(plugin.info.identifier);
print(plugin.info.appVersionName);
print(plugin.info.appVersionCode);
print(plugin.info.appName);
print(plugin.info.packageName);