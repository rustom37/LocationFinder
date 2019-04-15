//
//  ViewController.swift
//  LocationFinder
//
//  Created by Steve Rustom on 4/12/19.
//  Copyright © 2019 Steve Rustom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let locationFinder = FindMyLocation(name: "Estimote", uuid: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")! ,majorValue: 50075, minorValue: 56949)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationFinder.requestAuthorization()
        locationFinder.startMonitoring()
    }
}



