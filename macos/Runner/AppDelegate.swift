import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  override func applicationDidFinishLaunching(_ notification: Notification) {
    let controller = mainFlutterWindow?.contentViewController as! FlutterViewController

    FlutterMethodChannel(
      name: "com.example.app/version",
      binaryMessenger: controller.engine.binaryMessenger
    ).setMethodCallHandler { (call, result) in
      switch call.method {
      case "getBatteryLevel":
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let osVersion = ProcessInfo.processInfo.operatingSystemVersionString
        result("\(appVersion ?? "unknown") (macOS \(osVersion))")
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }
}
