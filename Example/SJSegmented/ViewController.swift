//
//  ViewController.swift
//  SJSegmented
//
//  Created by dimacheverda on 03/27/2018.
//  Copyright (c) 2018 dimacheverda. All rights reserved.
//

import UIKit
import SJSegmented

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: SegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.items = ["First", "Second", "Third"]
        segmentedControl.textDefaultColor = UIColor.orange
        segmentedControl.textSelectedColor = UIColor.red
        segmentedControl.underlineColor = UIColor.red
        segmentedControl.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
    }
}
