import UIKit
import Flutter
import FirebaseCore

import GoogleMaps
//import GooglePlaces


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()
//      GMSPlacesClient.provideAPIKey("Your key")
      GMSServices.provideAPIKey("AIzaSyDx3BFhusvPEFSbiKdUsLaZUZaU8b0hRLM")
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
