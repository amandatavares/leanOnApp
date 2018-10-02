//
//  VelocityTrackController.swift
//  testandoWatch WatchKit Extension
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import WatchKit

import CoreLocation
import WatchConnectivity

class VelocityTrackController: WKInterfaceController {

    @IBOutlet var ring: WKInterfaceImage!
    
    var progressWrapper: ProgressCircleWrapper?
    var speedTracker: SpeedTracker = SpeedTracker()
    var healthManager: HealthManager = HealthManager()
    
    override func willActivate() {
        
        super.willActivate()
        
        if WCSession.isSupported() {
            
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        progressWrapper = ProgressCircleWrapper.init(interfaceImage: ring, imageSet: "green_progress", current: 5, max: 100, stepInterval: 0.1)
        progressWrapper?.stopsOnMaxValue = false
        progressWrapper?.delegate = self
        
        healthManager.getTodayDistance { (result) in
            print(result)
        }
        
        speedTracker.startTracking()
        formatAndUpdateLabels(currentSpeed: speedTracker.currentSpeed, maxSpeed: speedTracker.maxSpeed)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: SpeedTracker.Notifications.CurrentSpeedNotification.rawValue), object: speedTracker, queue: OperationQueue.main) { [weak self] (notification: Notification) -> Void in
            
            if let currentSpeedNumber = notification.userInfo?[SpeedTracker.Notifications.CurrentSpeed] as? NSNumber,
                let maxSpeedNumber = notification.userInfo?[SpeedTracker.Notifications.MaxSpeed] as? NSNumber {
                
                self?.formatAndUpdateLabels(currentSpeed: currentSpeedNumber.doubleValue, maxSpeed: maxSpeedNumber.doubleValue)
            }
        }
        
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: SpeedTracker.Notifications.CurrentDistanceNotification.rawValue), object: speedTracker, queue: OperationQueue.main) { [weak self] (notification: Notification) -> Void in
            if let currentDistance = notification.userInfo?[SpeedTracker.Notifications.CurrentDistance] as? NSNumber {
                
                self?.formatAndUpdateDistanceLabel(currentDistance: currentDistance.doubleValue)
            }
        }
        
        
    }
    
    private func formatAndUpdateLabels(currentSpeed: Double, maxSpeed: Double) {
        print("\(currentSpeed), \(maxSpeed)")
    }
    
    private func formatAndUpdateDistanceLabel(currentDistance: Double) {
       print("\(currentDistance)")
        
    }

}

extension VelocityTrackController: ProgressCircleDelegate {
    func didStartAnimating(progress: ProgressCircleWrapper, from: Int, to: Int) {
        
    }
    
    func didReachMaximum(progress: ProgressCircleWrapper) {
        
    }
    
    func didSurpassMaximum(progress: ProgressCircleWrapper) {
        
    }
}



extension VelocityTrackController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
        print(message)
    }
}
