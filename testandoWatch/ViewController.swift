//
//  ViewController.swift
//  testandoWatch
//
//  Created by Ada 2018 on 26/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationManager = NotificationManager()
        
        notificationManager.register()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }


}

