package com.example.doodle

import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val BATTERY_CHANNEL = "com.example.app/battery"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BATTERY_CHANNEL)
        .setMethodCallHandler { call, result ->
            when (call.method) {
                "getNativeVersion" -> {
                    val appVersion = packageManager
                        .getPackageInfo(packageName, 0).versionName
                    val osVersion = android.os.Build.VERSION.RELEASE
                    result.success("$appVersion (Android $osVersion)")
                }
                "getBatteryLevel" -> {
                    val batteryLevel = getBatteryLevel()
                    if (batteryLevel != -1) result.success(batteryLevel) else result.error("UNAVAILABLE", "Battery level not available.", null)   
                }
                "getBatteryStatus" -> {
                    val status = getBatteryStatus()
                    result.success(status)
                }
                "getDeviceName" -> {
                    val deviceName = getDeviceName()
                    result.success(deviceName)
                }
                "getBatteryTemperature" -> {
                    val batteryTemperature = getBatteryTemperature()
                    result.success(batteryTemperature)
                }
                "getBatteryVoltage" -> {
                    val voltage = getBatteryVoltage()
                    result.success(voltage)
                }
                else -> result.notImplemented()
            } 
        }
    }

    private fun getBatteryIntent(): Intent? {
    val filter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
    return if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.TIRAMISU) {
            registerReceiver(null, filter, Context.RECEIVER_EXPORTED)
        } else {
            registerReceiver(null, filter)
        }
    }
    private fun getBatteryLevel(): Int {
        return getBatteryIntent()?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
    }

    private fun getBatteryVoltage(): String {
        val voltage = getBatteryIntent()?.getIntExtra(BatteryManager.EXTRA_VOLTAGE, -1) ?: -1
        return if (voltage == -1) "Unavailable" else "${voltage / 1000.0}V"
    }

    private fun getBatteryStatus(): String {
        val status = getBatteryIntent()?.getIntExtra(BatteryManager.EXTRA_STATUS, -1) ?: -1
        return when(status) {
            BatteryManager.BATTERY_STATUS_CHARGING -> "Charging 🔌"
            BatteryManager.BATTERY_STATUS_FULL -> "Full ✅"
            BatteryManager.BATTERY_STATUS_DISCHARGING -> "Discharging 🔋"
            BatteryManager.BATTERY_STATUS_NOT_CHARGING -> "Not Charging"
            else -> "Unknown ❓ (status = $status)"
        }
    }

    private fun getBatteryTemperature(): String {
        val temp = getBatteryIntent()?.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, -1) ?: -1
        return if (temp == -1) "-1.0" else "${temp / 10.0}°C"
    }

    private fun getDeviceName(): String {
        val manufacturer = android.os.Build.MANUFACTURER  // e.g. "Samsung"
        val model = android.os.Build.MODEL                // e.g. "SM-G991B"
    
        return if (model.startsWith(manufacturer, ignoreCase = true)) {
            model  // avoids "Samsung Samsung Galaxy S21"
        } else {
            "$manufacturer $model"  // e.g. "Samsung Galaxy S21"
        }
    }
}
