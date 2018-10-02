//
//  ViewController.swift
//  testandoWatch
//
//  Created by Ada 2018 on 26/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit
import CoreLocation
import WatchKit
import WatchConnectivity

class ViewController: UIViewController {

    var speedTracker: SpeedTracker = SpeedTracker()
    var healthManager: HealthManager = HealthManager()
    
    @IBOutlet weak var velocityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationManager = NotificationManager()
        
        notificationManager.register()
        
        self.healthManager.auth()
        self.startTrackingOrShowLocationAlert(tracker: self.speedTracker)
        disableIdleTimerIfWanted()
        
        speedTracker.startTracking()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: SpeedTracker.Notifications.CurrentSpeedNotification.rawValue), object: speedTracker, queue: OperationQueue.main) { [weak self] (notification: Notification) -> Void in
            
            if let currentSpeedNumber = notification.userInfo?[SpeedTracker.Notifications.CurrentSpeed] as? NSNumber,
                let maxSpeedNumber = notification.userInfo?[SpeedTracker.Notifications.MaxSpeed] as? NSNumber {
                
                
                
                
            }
        }
    }
    
    @IBAction func testeCon(_ sender: Any) {
        if WCSession.default.isReachable {
            let message = ["message" : "hello"]
            WCSession.default.sendMessage(message, replyHandler: { (reply) in
                
            print("ok")
            }) { (error) in
                
            print("erro")
            }
            WCSession.default.sendMessage(message, replyHandler: nil, errorHandler: nil)
        }
    }

    private func startTrackingOrShowLocationAlert(tracker: SpeedTracker) {
        speedTracker.startTracking()
        
        let locationPermissions = CLLocationManager.authorizationStatus()
        if locationPermissions == .restricted || locationPermissions == .denied {
            let alertController = UIAlertController(title: "Location Services Required", message: "Location services must be enabled for this app, and turned on in Settings, in order to display your speed.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           self.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func disableIdleTimerIfWanted() {
        let settingsWantsScreenDimmingDisabled =  UserDefaults.standard.bool(forKey: "Speed.KeepScreenAwake")
        UIApplication.shared.isIdleTimerDisabled = settingsWantsScreenDimmingDisabled
    }
}

