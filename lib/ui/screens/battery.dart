import 'dart:async';

import 'package:flutter/material.dart';

import '/services/battery_service.dart';
import '/ui/components/info_card.dart';
import '/theme.dart';

class BatteryScreen extends StatefulWidget {
  const BatteryScreen({super.key});

  @override
  BatteryScreenState createState() => BatteryScreenState();
}

class BatteryScreenState extends State<BatteryScreen> {
  int batteryLevel = 0;

  String status = "Unavaliable";

  String device = "Unavaliable";

  String temperature = "Unavaliable";

  String voltage = "Unavaliable";

  late final Timer _timer;

  void updateBattery() async {
    int? newLevel = await BatteryService.getBatteryLevel();
    String newStatus = await BatteryService.getBatteryStatus();
    String newVoltage = await BatteryService.getBatteryVoltage();
    String newTemperature = await BatteryService.getBatteryTemperature();
    if (!mounted) return;
    setState(() {
      status = newStatus;
      voltage = newVoltage;
      batteryLevel = newLevel ?? 0;
      temperature = newTemperature;
    });
  }

  void getDeviceInfo() async {
    String deviceName = await BatteryService.getDeviceName();
    if (!mounted) return;
    setState(() {
      device = deviceName;
    });
  }

  @override
  void initState() {
    super.initState();

    getDeviceInfo();
    updateBattery();
    _timer = Timer.periodic(Duration(seconds: 5), (_) => updateBattery());
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).styles;

    return Scaffold(
      backgroundColor: styles.colors.background,
      body: SafeArea(
        child: Padding(
          padding: const .all(24.0),
          child: Column(
            children: [
              Text("Battery Monitor", style: styles.font.pageTitle),
              Text("currently works only on Android", style: styles.font.small),
              SizedBox(height: 40),
              Stack(
                alignment: .center,
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: CircularProgressIndicator(
                      value: batteryLevel / 100,
                      strokeWidth: 12,
                      color: batteryLevel > 30
                          ? styles.colors.success
                          : batteryLevel > 15
                          ? styles.colors.warning
                          : styles.colors.error,
                      backgroundColor: styles.colors.progressBar,
                    ),
                  ),
                  Text("$batteryLevel%", style: styles.font.header),
                ],
              ),
              SizedBox(height: 50),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    InfoCard(title: "Voltage", value: voltage),
                    InfoCard(title: "Temperature", value: temperature),
                    InfoCard(title: "Status", value: status),
                    InfoCard(title: "Device", value: device),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
