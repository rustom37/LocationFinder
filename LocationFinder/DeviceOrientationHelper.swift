//
//  DeviceOrientationHelper.swift
//  LocationFinder
//
//  Created by Steve Rustom on 4/15/19.
//  Copyright © 2019 Steve Rustom. All rights reserved.
//

import Foundation
import CoreMotion
import UIKit

class DeviceOrientationHelper {
    static let shared = DeviceOrientationHelper()
    
    private let motionManager : CMMotionManager
    private let queue : OperationQueue
    
    typealias DeviceOrientationHandler = ((_ deviceOrientation: UIDeviceOrientation) -> Void)?
    private var deviceOrientationAction: DeviceOrientationHandler?
    
    public var currentDeviceOrientation: UIDeviceOrientation = .portrait
    
    private let motionLimit: Double = 0.6
    
    init() {
        motionManager = CMMotionManager()
        motionManager.accelerometerUpdateInterval = 0.2
        
        queue = OperationQueue()
    }
    
    public func startDeviceOrientationNotifier(with handler: DeviceOrientationHandler) {
        self.deviceOrientationAction = handler
        
        motionManager.startAccelerometerUpdates(to: queue) { (data, error) in
            if let accelerometerData = data {
                var newDeviceOrientation = UIDeviceOrientation(rawValue: 1)
                
                if (accelerometerData.acceleration.x >= self.motionLimit) {
                    newDeviceOrientation = .landscapeLeft
                }
                else if (accelerometerData.acceleration.x <= -self.motionLimit) {
                    newDeviceOrientation = .landscapeRight
                }
                else if (accelerometerData.acceleration.y <= -self.motionLimit) {
                    newDeviceOrientation = .portrait
                }
                else if (accelerometerData.acceleration.y >= self.motionLimit) {
                    newDeviceOrientation = .portraitUpsideDown
                }
                else {
                    return
                }
                
                if newDeviceOrientation != self.currentDeviceOrientation {
                    self.currentDeviceOrientation = newDeviceOrientation ?? .portrait
                    if let deviceOrientationHandler = self.deviceOrientationAction {
                        DispatchQueue.main.async {
                            deviceOrientationHandler!(self.currentDeviceOrientation)
                        }
                    }
                }
            }
        }
    }
    
    public func stopDeviceOrientationNotifier() {
        motionManager.stopAccelerometerUpdates()
    }
}
