//
//  SpeedFormat.swift
//  Speed
//
//  Created by Chris Dzombak on 5/9/16.
//  Copyright © 2016 Chris Dzombak. All rights reserved.
//

import Foundation

/// Convert and format speed from km/h to mph according user metric system
///
/// - Parameter speed: the speed to be formatted
/// - Returns: the speed as string to be placed on a label
func formatForCurrentLocale(speedInMetersPerSecond speed: Double) -> String {
    guard let metricNumber = NSLocale.current.usesMetricSystem as? NSNumber else { fatalError() }
    let useMetric = metricNumber.boolValue
    
    if useMetric {
        let convertedSpeed = round(speed * 3.6)
        let speedString = String(format: "%.0f", convertedSpeed)
        return "\(speedString) km/h"
    } else {
        let convertedSpeed = round(speed * 2.23694)
        let speedString = String(format: "%.0f", convertedSpeed)
        return "\(speedString) mph"
    }
}

/// Format distance in a text string with meters
///
/// - Parameter distance: the distance in meters to be formatted
/// - Returns: the distance as string to be placed on a label
func formatForCurrentLocale(distanceInMeters distance: Double) -> String {
    return "\(distance) m"
}
