import 'package:flutter/services.dart';

class BatteryService {
  static const _channel = MethodChannel('com.example.app/battery');

  static Future<String> getNativeVersion() async {
    try {
      return await _channel.invokeMethod('getNativeVersion');
    } on PlatformException {
      return 'Unavaliable';
    }
  }

  static Future<String> getDeviceName() async {
    try {
      return await _channel.invokeMethod('getDeviceName');
    } on PlatformException {
      return 'Unavailable';
    }
  }

  static Future<int?> getBatteryLevel() async {
    try {
      return await _channel.invokeMethod<int>('getBatteryLevel');
    } on PlatformException {
      return null;
    }
  }

  static Future<String> getBatteryStatus() async {
    try {
      return await _channel.invokeMethod('getBatteryStatus');
    } on PlatformException {
      return 'Unavailable';
    }
  }

  static Future<String> getBatteryTemperature() async {
    try {
      return await _channel.invokeMethod('getBatteryTemperature');
    } on PlatformException {
      return 'Unavailable';
    }
  }

  static Future<String> getBatteryVoltage() async {
    try {
      return await _channel.invokeMethod('getBatteryVoltage');
    } on PlatformException {
      return 'Unavailable';
    }
  }
}
