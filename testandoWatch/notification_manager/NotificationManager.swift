//
//  NotificationManager.swift
//  testandoWatch
//
//  Created by Ada 2018 on 26/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationManager{
    
    func rememberNotification() -> UNNotificationCategory{
        let openAction = UNNotificationAction.init(
            identifier: NotificationActionID.remmember.rawValue,
            title: NotificationActionName.remmember.rawValue,
            options: UNNotificationActionOptions.init(rawValue: 0)
        )
        
        let category = UNNotificationCategory.init(
            identifier: NotificationCategoryID.doExercises.rawValue,
            actions: [openAction], intentIdentifiers: [],
            options: .customDismissAction
        )
        
        return category
    }
    
    func requestPermission(completion: @escaping (Bool, Error?) -> (Void)){
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.requestAuthorization(options: UNAuthorizationOptions.init(rawValue: 0), completionHandler: completion)
    }
    
    func sendRemmeber(){
        let content = UNMutableNotificationContent()
        content.title = "teste"
    }
    
    func register(){
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.setNotificationCategories(
            [rememberNotification()]
        )
    }
    
    func printNot() {
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests { pending in
            print(pending)
        }
    }
    
    func setUp(){
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent.init()
        content.title = "Jurassic Park"
        content.subtitle = "Lunch"
        content.body = "body"
        content.categoryIdentifier = NotificationCategoryID.doExercises.rawValue

        let notificationTrigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 60, repeats: true)
        let request = UNNotificationRequest.init(identifier: "contentId", content: content, trigger: notificationTrigger)
    
        
        notificationCenter.add(request) { (error) in
            if let error  = error {
                print("erro")
            }
        }
    }
}
