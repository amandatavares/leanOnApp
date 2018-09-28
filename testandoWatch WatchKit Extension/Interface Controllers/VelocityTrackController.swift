//
//  VelocityTrackController.swift
//  testandoWatch WatchKit Extension
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import WatchKit

class VelocityTrackController: WKInterfaceController {

    @IBOutlet var ring: WKInterfaceImage!
    var progressWrapper: ProgressCircleWrapper?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        progressWrapper = ProgressCircleWrapper.init(interfaceImage: ring, imageSet: "green_progress", current: 5, max: 100, stepInterval: 0.1)
        progressWrapper?.stopsOnMaxValue = false
        
        progressWrapper?.delegate = self
        
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


