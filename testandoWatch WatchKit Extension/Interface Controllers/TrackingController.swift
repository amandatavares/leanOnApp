//
//  TrackingController.swift
//  testandoWatch WatchKit Extension
//
//  Created by Ada 2018 on 26/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import WatchKit

class TrackingController: WKInterfaceController {
    
   
    @IBOutlet var ring: WKInterfaceImage!
    var progressWrapper: ProgressCircleWrapper?
    var healthManager: HealthManager = HealthManager.init()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        progressWrapper = ProgressCircleWrapper.init(interfaceImage: ring, imageSet: "blue_progress", current: 5, max: 100, stepInterval: 0.1)
        progressWrapper?.stopsOnMaxValue = false
        
        progressWrapper?.delegate = self
        
        healthManager.auth()
        healthManager.getTodayDistance { (result) in
            print("titi")
            print(result)
        }
        
                
    }
    
    
    @IBAction func btStepAction() {
        
        progressWrapper?.increment(value: 20)
    }
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}

extension TrackingController: ProgressCircleDelegate{
    func didSurpassMaximum(progress: ProgressCircleWrapper) {
        print("surpass")
    }
    
    func didStartAnimating(progress: ProgressCircleWrapper, from: Int, to: Int) {
        print("anim")
    }
    
    func didReachMaximum(progress: ProgressCircleWrapper) {
        print("reach")
    }
}
