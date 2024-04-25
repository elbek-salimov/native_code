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
  String _deviceInfo = "Unknown device info.";

  Future<void> _getDeviceInfo() async {
    String result;
    try {
      await devicePlatform.invokeMethod('getDeviceInfo').then((value) {
        result = value.toString();
        setState(() {
          _deviceInfo = result;
        });
      });
    } on PlatformException catch (e) {
      debugPrint("_getDeviceInfo==>${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Platform Specific"),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_batteryLevel, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text(_deviceInfo, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () async {
                _getDeviceInfo();
              },
              child: const Icon(Icons.mobile_friendly),
            ),
            FloatingActionButton(
              onPressed: () {
                _getBatteryLevel();
              },
              child: const Icon(Icons.battery_0_bar),
            ),
          ],
        ),
      ),
    );
  }
}
