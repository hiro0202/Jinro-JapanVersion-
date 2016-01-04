//
//  TimerViewController.swift
//  OneNightJinroInCar
//
//  Created by OtsukaHiromichi on 2015/06/07.
//  Copyright (c) 2015年 OtsukaHiromichi. All rights reserved.
//

import UIKit
import iAd

class TImerViewController: UIViewController ,ADBannerViewDelegate{
    
    @IBOutlet weak var CardNumLabel: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!
    var startTime : NSTimeInterval?
    var timer : NSTimer?
    var total : Int = 5
    
    @IBOutlet weak var adview: ADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.adview.delegate = self
        self.adview.hidden = true
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let def = NSUserDefaults.standardUserDefaults()
        var PlayerRoles:[NSString] = def.objectForKey("PlayerRolesTraded") as! [NSString]
        def.setObject(PlayerRoles, forKey: "PlayerRoles")
        def.synchronize()
        
        var CardNum:[Int] = []
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        CardNum = appDelegate.CardNum
        CardNumLabel.text = "町:\(CardNum[0]) 虎:\(CardNum[1]) 侍:\(CardNum[2]) 歌:\(CardNum[3]) 貘:\(CardNum[4])"
        
        //タイマーの時間設定

        var TalkTime: Int = def.objectForKey("TalkTime") as! Int
        total = TalkTime * 60
        var totalH = total/3600
        var totalM = (total - totalH*3600)/60
       // TimerLabel.text = "\(totalM):\(total%60)"
        TimerLabel.text = NSString(format: "%02d:%02d", totalM,total%60) as String
        //timerlabel.text = [NSString stringWithFormat:@"%02d:%02d", // 「分」「秒」のそれぞれの位を、二桁の整数値で表す。intTotalM, total%60];
        
        startTime = NSDate.timeIntervalSinceReferenceDate()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector:Selector("timerUpdate:"), userInfo: nil, repeats: true)
        timer?.fire()

        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
            }
    
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    func timerUpdate(timer : NSTimer){
        var time : NSTimeInterval = NSDate.timeIntervalSinceReferenceDate() - startTime!
        var restTime = total - NSInteger(time)
        var restTimeH = restTime/3600
        var restTimeM = (restTime - restTimeH*3600)/60
        //TimerLabel.text = "\(restTimeM):\(restTime%60)"
        TimerLabel.text = NSString(format: "%02d:%02d", restTimeM,restTime%60) as String
        
        if(restTime <= 0){
            timer.invalidate()
            //終了
            let secondVC: ExecutionViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ExecutionVC") as! ExecutionViewController
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    
    @IBAction func FinishBtn(sender: AnyObject) {
        let secondVC: ExecutionViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ExecutionVC") as! ExecutionViewController
        self.navigationController?.pushViewController(secondVC, animated: true)
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

