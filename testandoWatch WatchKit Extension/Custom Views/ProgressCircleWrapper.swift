//
//  WKProgressCircle.swift
//  testandoWatch
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import WatchKit

public class ProgressCircleWrapper {
    private var current: Int?
    public var stepInterval: Double = 1
    public var max: Int = 100
    public var imageSet: String?
    public var stopsOnMaxValue: Bool = false
    public var delegate: ProgressCircleDelegate?
    
    public weak var interfaceImage: WKInterfaceImage? {
        didSet {
            
            if let imageSet = self.imageSet{
                
                self.interfaceImage?.setImageNamed(imageSet)
            }
        }
    }
    
    public init(interfaceImage: WKInterfaceImage, imageSet: String, current: Int = 0, max: Int, stepInterval: Double = 0.1){
        
        self.imageSet = imageSet
        self.interfaceImage = interfaceImage
        self.interfaceImage?.setImageNamed(self.imageSet)
        
        self.max = max
        self.current = current
        self.stepInterval = stepInterval
        
        animate(oldValue: 0, newValue: current)
    }
    
    public func increment(value: Int){
        
        self.change(to: (self.current ?? 0) + abs(value))
    }
    
    public func change(to value: Int){
        
        let absValue = abs(value)

        if let current = self.current {
            if absValue <= self.max {
                
                self.animate(oldValue: current, newValue: absValue)
                self.current = absValue
                
                if absValue == self.max {
                    delegate?.didReachMaximum(progress: self)
                }
                
            } else if !self.stopsOnMaxValue{
                
                self.current = value % self.max
                
                animate(oldValue: 0, newValue: self.current!)
                delegate?.didSurpassMaximum(progress: self)
            } else if self.stopsOnMaxValue {
                
                self.animate(oldValue: current, newValue: max)
                self.current = max
            
                delegate?.didReachMaximum(progress: self)
            }
        }
    }
    
    private func animate(oldValue:Int, newValue: Int){
        let animationTime = Double(newValue - oldValue) * self.stepInterval
        
        self.delegate?.didStartAnimating(progress: self, from: oldValue, to: newValue)
        self.interfaceImage?.startAnimatingWithImages(in: NSRange(location: oldValue, length: newValue - oldValue + 1), duration: TimeInterval(animationTime), repeatCount: 1)
        
    }
    
    public func currentValue() -> Int{
        return self.current ?? 0
    }
}
