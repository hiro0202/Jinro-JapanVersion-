//
//  ViewController.swift
//  Jinro-Wa-
//
//  Created by OtsukaHiromichi on 2015/06/14.
//  Copyright (c) 2015年 OtsukaHiromichi. All rights reserved.
//

import UIKit
import iAd

class ViewController: UIViewController,ADBannerViewDelegate{

    @IBOutlet weak var adivew: ADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.adivew.delegate = self
        self.adivew.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        self.adivew?.hidden = false
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        return willLeave
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        self.adivew?.hidden = true
    }


}

