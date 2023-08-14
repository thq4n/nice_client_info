import 'package:flutter/material.dart';

// Import package
import 'package:nice_client_info/nice_client_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Nice Client Info',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Nice Client Info Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NiceClientInfoPlugin? plugin;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: _initPlugin(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: onGetModel,
                    child: const Text(
                      'Get Model Info',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onOSVersion,
                    child: const Text(
                      'Get OS Version Info',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onAppVersionName,
                    child: const Text(
                      'Get App Version Name Info',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onAppVersionCode,
                    child: const Text(
                      'Get App Version Code Info',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onAppName,
                    child: const Text(
                      'Get App Name Info',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onPackageName,
                    child: const Text(
                      'Get Package Name Info',
                    ),
                  ),
                ],
              );
            }

            return const CircularProgressIndicator.adaptive();
          },
        ),
      ),
    );
  }

  void showPopup(String? message) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            message ?? 'Error',
          ),
        ),
      ),
    );
  }

  void onGetModel() {
    showPopup(plugin?.info.model);
  }

  void onOSVersion() {
    showPopup(plugin?.info.osversion);
  }

  void onAppVersionName() {
    showPopup(plugin?.info.appVersionName);
  }

  void onAppVersionCode() {
    showPopup(plugin?.info.appVersionCode);
  }

  void onAppName() {
    showPopup(plugin?.info.appName);
  }

  void onPackageName() {
    showPopup(plugin?.info.packageName);
  }

  Future<NiceClientInfoPlugin> _initPlugin() async {
    final plugin = await NiceClientInfoPlugin.instance.setup();

    this.plugin = plugin;

    return plugin;
  }
}
