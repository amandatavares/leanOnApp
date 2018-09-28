//
//  ProgressCircleDelegate.swift
//  testandoWatch WatchKit Extension
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit

public protocol ProgressCircleDelegate {

    func didStartAnimating(progress: ProgressCircleWrapper, from: Int, to: Int)
    func didReachMaximum(progress: ProgressCircleWrapper)
    func didSurpassMaximum(progress: ProgressCircleWrapper)
    
}
