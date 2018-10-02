//
//  SpeedTracker.swift
//  Speed
//
//  Created by Chris Dzombak on 5/9/16.
//  Copyright © 2016 Chris Dzombak. All rights reserved.
//

import Foundation
import CoreLocation

class SpeedTracker: NSObject, CLLocationManagerDelegate {
    
    enum Notifications: String {
        case CurrentSpeedNotification
        case CurrentDistanceNotification
        
        static let CurrentSpeed = "SpeedTracker.CurrentSpeed"
        static let MaxSpeed = "SpeedTracker.MaxSpeed"
        static let CurrentDistance = "SpeedTracker.CurrentDistance"
    }
    
    private(set) var currentSpeed: Double
    private(set) var maxSpeed: Double
    var currentDistance: Double
    var olderLocation: CLLocation?
    var distance: Double
    
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        currentSpeed = 0.0
        maxSpeed = 0.0
        currentDistance = 0.0
        distance = 0.0
        
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    /// Request user authorization to get Location and start updating it.
    func startTracking() {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.startUpdatingLocation()
    }
    
    /// Stop updating location.
    func stopTracking() {
        locationManager.stopUpdatingLocation()
    }
    
    func resetMaxSpeed() {
        DispatchQueue.main.async() { [weak self] in
            guard let `self` = self else { return }
            
            self.maxSpeed = 0.0
            self.updateSpeed(speedInMetersPerSecond: self.currentSpeed)
        }
    }
    
    /** Updates the speed through the Notification Center. It defines the currentSpeed and maxSpeed
 
     - Parameter speedInMetersPerSecond: the speed in meters per second. Must to be double.
     */
    private func updateSpeed(speedInMetersPerSecond: Double) {
        DispatchQueue.main.async() { [weak self] in
            guard let `self` = self else { return }
            
            self.currentSpeed = max(0.0, speedInMetersPerSecond)
            self.maxSpeed = max(self.maxSpeed, self.currentSpeed)
            
            let userInfo = [
                Notifications.CurrentSpeed: NSNumber(value: self.currentSpeed),
                Notifications.MaxSpeed: NSNumber(value: self.maxSpeed),
                ]
            
            //NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notifications.CurrentSpeedNotification.rawValue), object: self)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notifications.CurrentSpeedNotification.rawValue), object: self, userInfo: userInfo)
            
        }
    }
    
    /** Updates the distance through the Notification Center. It defines the currentDistance.
     
     - Parameter distanceInMeters: the distance in meters. Must to be double.
     */
    private func updateDistance(distanceInMeters: Double) {
        DispatchQueue.main.async() { [weak self] in
            guard let `self` = self else { return }
            
            let userInfo = [
                Notifications.CurrentDistance: NSNumber(value: self.distance),
                ]
            
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notifications.CurrentDistanceNotification.rawValue), object: self, userInfo: userInfo)
        }
    }
    
    
    // MARK: CLLocationManagerDelegate
    
    /// Teels the delegate that new location data is available
    ///
    /// - Parameters:
    ///   - manager: location manager
    ///   - locations: receives a list of Locations, where we can get the last
    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        
        updateSpeed(speedInMetersPerSecond: lastLocation.speed)
        if let older = self.olderLocation {
            let distance = lastLocation.distance(from: older).rounded()
            updateDistance(distanceInMeters: distance)
            self.olderLocation = lastLocation
            
            
            self.distance += distance
        }
        else {
            self.olderLocation = lastLocation
        }
    }
}

// MARK: Persistence

extension SpeedTracker {
    private enum Defaults: String {
        case CurrentSpeed = "SpeedTracker.CurrentSpeed"
        case MaxSpeed = "SpeedTracker.MaxSpeed"
    }
}
