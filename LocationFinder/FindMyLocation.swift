//
//  FindMyLocation.swift
//  LocationFinder
//
//  Created by Steve Rustom on 4/12/19.
//  Copyright © 2019 Steve Rustom. All rights reserved.
//

import Foundation
import CoreLocation

class FindMyLocation: NSObject, CLLocationManagerDelegate {
    
    let majorValue : CLBeaconMajorValue
    let minorValue : CLBeaconMinorValue
    let uuid : UUID
    let name : String
    let locationManager = CLLocationManager()
    
    init(name: String, uuid: UUID, majorValue: Int, minorValue: Int) {
        self.name = name
        self.uuid = uuid
        self.majorValue = CLBeaconMajorValue(majorValue)
        self.minorValue = CLBeaconMinorValue(minorValue)
    }
    
    func requestAuthorization() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            print("Authorization always granted.")
        case .authorizedWhenInUse:
            print("Authorization granted when in use.")
        default:
            print("Authorization not granted.")
        }
    }
    
    private func asBeaconRegion() -> CLBeaconRegion {
        let region = CLBeaconRegion(proximityUUID: uuid, major: majorValue, minor: minorValue, identifier: name)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        return region
    }
    
    func startMonitoring() {
        print("Start Monitoring")
        let beaconRegion = self.asBeaconRegion()
        beaconRegion.notifyEntryStateOnDisplay = true
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startUpdatingLocation()
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Did enter.")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Did exit.")
    }
}
