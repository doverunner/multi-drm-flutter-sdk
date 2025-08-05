import Foundation
import UIKit
import AVKit
import Flutter
import DoveRunnerFairPlay

@main
@objc class AppDelegate: FlutterAppDelegate {
    
    var doverunnerSdk: DoveRunnerFairPlay?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let flutterChannel = FlutterMethodChannel(name: "com.doverunner/startActivity",
                                                   binaryMessenger: controller.binaryMessenger)
        
        flutterChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            guard call.method == "StartSecondActivity" else {
                result(FlutterMethodNotImplemented)
                return
            }
            let arguments: String = call.arguments as! String
            self?.startPlay(jsonString: arguments, flutterViewController: controller)
        })
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func startPlay(jsonString: String, flutterViewController: FlutterViewController) {
        guard let json = try? JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: []) as? [String: Any] else {
            return
        }
        
        guard let url = json["url"] as? String, let drmJson = json["drmConfig"] as? [String: Any] else {
            print("URL or DRM Configuration is nil!")
            return
        }
        
        let contentId = drmJson["contentId"] as? String ?? ""
        let drmLicenseUrl = drmJson["drmLicenseUrl"] as? String ?? ""
        let siteId = drmJson["siteId"] as? String ?? ""
        let token = drmJson["token"] as? String ?? ""
        let userId = drmJson["userId"] as? String ?? "utest"

        // 1. FairPlay SDK initialize
        doverunnerSdk = DoveRunnerFairPlay()
        guard let contentUrl = URL(string: url) else {
            return
        }
        
        let urlAsset = AVURLAsset(url: contentUrl)
        
        // 2. Acquire a Token information
        let drm_config = FairPlayConfiguration(avURLAsset: urlAsset,
                                                contentId: contentId,
                                                certificateUrl: "https://drm-license.doverunner.com/ri/fpsKeyManager.do?siteId=\(siteId)",
                                                authData: token, delegate: self)
        doverunnerSdk?.prepare(drm: drm_config)
        
        let playerItem = AVPlayerItem(asset: urlAsset)
        let avPlayer = AVPlayer(playerItem: playerItem)
        let playerView = AVPlayerViewController()
        playerView.player = avPlayer
        flutterViewController.present(playerView, animated: true, completion: {
            avPlayer.play()
        })
    }
}

extension AppDelegate: FairPlayLicenseDelegate {
    func license(result: LicenseResult) {
         print("---------------------------- License Result ")
         print("Content ID : \(result.contentId)")
         print("Key ID     : \(String(describing: result.keyId))")

         var message: String?
         if result.isSuccess == false {
              print("Error : \(String(describing: result.error?.localizedDescription))")
              if let error = result.error {
                   switch error {
                   case .database(comment: let comment):
                        print(comment)
                        message = comment
                   case .server(errorCode: let errorCode, comment: let comment):
                        print("code : \(errorCode), comment: \(comment)")
                        message = "code : \(errorCode), comment: \(comment)"
                   case .network(errorCode: let errorCode, comment: let comment):
                        print("code : \(errorCode), comment: \(comment)")
                        message = "code : \(errorCode), comment: \(comment)"
                   case .system(errorCode: let errorCode, comment: let comment):
                        print("code : \(errorCode), comment: \(comment)")
                        message = "code : \(errorCode), comment: \(comment)"
                   case .failed(errorCode: let errorCode, comment: let comment):
                        print("code : \(errorCode), comment: \(comment)")
                        message = "code : \(errorCode), comment: \(comment)"
                   case .unknown(errorCode: let errorCode, comment: let comment):
                        print("code : \(errorCode), comment: \(comment)")
                        message = "code : \(errorCode), comment: \(comment)"
                   case .invalid(comment: let comment):
                        print("comment: \(comment)")
                        message = "comment: \(comment)"
                   default:
                        print("comment: \(error)")
                        message = "comment: \(error)"
                       break
                   }
              }
//              DispatchQueue.main.async {
//                   if let topVC = UIApplication.topViewController() {
//                        let alert = UIAlertController(title: "License Failed", message: message, preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { Void in
//                             topVC.dismiss(animated: true, completion: nil)
//                        }))
//                        topVC.present(alert, animated: true, completion: nil)
//                   }
//              }
         }
    }
}
