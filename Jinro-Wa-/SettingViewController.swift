//
//  SettingViewController.swift
//  OneNightJinroInCar
//
//  Created by OtsukaHiromichi on 2015/06/06.
//  Copyright (c) 2015年 OtsukaHiromichi. All rights reserved.
//

import UIKit
import iAd

class SettingViewController: UIViewController,ADBannerViewDelegate{
    
     var PlayerRoles:[NSString] = ["村人","無し","無し","無し","無し","無し","無し"]
    
    @IBOutlet weak var adview: ADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        firstRun()
        self.adview.delegate = self
        self.adview.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        firstRun()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //////////////アクション設定/////////////////
    //話し合い時間設定
    @IBAction func timeBtn(sender: UISegmentedControl) {
        let defaults = NSUserDefaults.standardUserDefaults()
        var TalkTime: Int = defaults.objectForKey("TalkTime") as! Int
        switch sender.selectedSegmentIndex{
        case 0:
            TalkTime = 5
            break
        case 1:
            TalkTime = 10
            break
        case 2:
            TalkTime = 15
            break
        case 3:
            TalkTime = 20
            break
        default:
            TalkTime = 5
            break
        }
        defaults.setObject(TalkTime, forKey: "TalkTime")
        defaults.synchronize()
        print(TalkTime);
    }

            //プレイヤー人数
    @IBAction func PlayNumBtn(sender: UIButton) {
        let def = NSUserDefaults.standardUserDefaults()
        def.setObject(sender.tag, forKey: "PlayerNum")
        print(sender.tag)
        def.synchronize()
        
        //StoryBoardのIdentiferからViewControllerを作ってShow
        let secondVC: PlayerNameViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PlayerNameVC") as! PlayerNameViewController
        //self.presentViewController(secondVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(secondVC, animated: true)
        }
    
    /////////////////新規関数///////////////////
    @IBOutlet weak var tmSeg: UISegmentedControl!

    //UserDefaultからスイッチ等の位置の設定
    func firstRun(){
        let def = NSUserDefaults.standardUserDefaults()
        let TalkTime = def.objectForKey("TalkTime") as! Int
        switch TalkTime{
        case 5:
            tmSeg.selectedSegmentIndex = 0
            break
        case 10:
            tmSeg.selectedSegmentIndex = 1
            break
        case 15:
            tmSeg.selectedSegmentIndex = 2
            break
        case 20:
            tmSeg.selectedSegmentIndex = 3
            break
        default:
            tmSeg.selectedSegmentIndex = 0
            break
        }
     def.setObject(PlayerRoles, forKey: "PlayerRoles")
    }
    
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        self.adview?.hidden = false
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        return willLeave
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        self.adview?.hidden = true
    }
    

}

