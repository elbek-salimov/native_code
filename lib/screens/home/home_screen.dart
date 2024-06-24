import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  static const devicePlatform = MethodChannel('flutter.native/helper');

  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final result = await platform.invokeMethod<int>('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  //Get device info
  String _model = "Unknown.";
  String _sdkVersion = "Unknown.";
  String _id = "Unknown.";
  String _version = "Unknown.";
  String _device = "Unknown.";
  String _manufacturer = "Unknown.";
  String _brand = "Unknown.";
  String _hardware = "Unknown.";
  String _android = "Unknown.";

  Future<void> _getDeviceInfo() async {
    try {
      final result = await devicePlatform.invokeMethod('getDeviceInfo');
      final deviceInfo = Map<String, dynamic>.from(result);
      setState(() {
        _model = deviceInfo['model'] ?? 'Unknown';
        _sdkVersion = deviceInfo['sdkVersion'] ?? 'Unknown';
        _id = deviceInfo['id'] ?? 'Unknown';
        _version = deviceInfo['version'] ?? 'Unknown';
        _device = deviceInfo['device'] ?? 'Unknown';
        _manufacturer = deviceInfo['manufacturer'] ?? 'Unknown';
        _brand = deviceInfo['brand'] ?? 'Unknown';
        _hardware = deviceInfo['hardware'] ?? 'Unknown';
        _android = deviceInfo['release'] ?? 'Unknown';
      });
    } on PlatformException catch (e) {
      debugPrint("_getDeviceInfo==>${e.message}");
    }
  }

  @override
  void initState() {
    _getBatteryLevel();
    _getDeviceInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Platform Specific"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: SizedBox(
              height: 40,
              width: 40,
              child: Image.asset('assets/icons/battery.png'),
            ),
            title: Text(
              _batteryLevel,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(
            thickness: 2,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            leading: SizedBox(
              height: 40,
              width: 40,
              child: Image.asset('assets/icons/model.png'),
            ),
            title: Text(
              "Model:  $_model;",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(
            thickness: 2,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            leading: SizedBox(
              height: 40,
              width: 40,
              child: Image.asset('assets/icons/version.png'),
            ),
            title: Text(
              "Sdk Version:  $_sdkVersion;",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(
            thickness: 2,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            leading: SizedBox(
              height: 40,
              width: 40,
              child: Image.asset('assets/icons/id.png'),
            ),
            title: Text(
              "ID:  $_id;",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(
            thickness: 2,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            leading: SizedBox(
              height: 40,
              width: 40,
              child: Image.asset('assets/icons/ver.png'),
            ),
            title: Text(
              "Version:  $_version;",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(
            thickness: 2,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            leading: SizedBox(
              height: 40,
              width: 40,
              child: Image.asset('assets/icons/device.png'),
            ),
            title: Text(
              "Device:  $_device;",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(
            thickness: 2,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            leading: SizedBox(
              height: 40,
              width: 40,
              child: Image.asset('assets/icons/man.png'),
            ),
            title: Text(
              "Manufacturer:  $_manufacturer;",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(
            thickness: 2,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            leading: SizedBox(
              height: 40,
              width: 40,
              child: Image.asset('assets/icons/brand.png'),
            ),
            title: Text(
              "Brand:  $_brand;",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(
            thickness: 2,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            leading: SizedBox(
              height: 40,
              width: 40,
              child: Image.asset('assets/icons/hardware.png'),
            ),
            title: Text(
              "Hardware:  $_hardware;",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(
            thickness: 2,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            leading: SizedBox(
              height: 40,
              width: 40,
              child: Image.asset('assets/icons/android.png'),
            ),
            title: Text(
              "Android:  $_android;",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(
            thickness: 2,
            indent: 15,
            endIndent: 15,
          ),
        ],
      ),
    );
  }
}
