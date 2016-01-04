//
//  PlayerNameViewController.swift
//  OneNightJinroInCar
//
//  Created by OtsukaHiromichi on 2015/06/06.
//  Copyright (c) 2015年 OtsukaHiromichi. All rights reserved.
//

import UIKit
import iAd

class PlayerNameViewController: UIViewController,ADBannerViewDelegate {
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var PlayerName1: UITextField!
    @IBOutlet weak var PlayerName2: UITextField!
    @IBOutlet weak var PlayerName3: UITextField!
    @IBOutlet weak var PlayerName4: UITextField!
    @IBOutlet weak var PlayerName5: UITextField!
    @IBOutlet weak var PlayerName6: UITextField!
    @IBOutlet weak var PlayerName7: UITextField!
    
    @IBOutlet var PNTextViews : [UITextField]!
    
    @IBOutlet weak var adview: ADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.adview.delegate = self
        self.adview.hidden = true
        
        //scrollview設定
        ScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2)
        
        //初期設定
        firstRun()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //////////////アクション設定/////////////////
    @IBAction func SettingFinishBtn(sender: AnyObject) {
        //UserDefaultsのユーザーネーム上書き
        let def = NSUserDefaults.standardUserDefaults()
        var PlayerNames:[NSString] = def.objectForKey("PlayerNames") as! [NSString]
        PlayerNames[0] = PlayerName1.text
        PlayerNames[1] = PlayerName2.text
        PlayerNames[2] = PlayerName3.text
        PlayerNames[3] = PlayerName4.text
        PlayerNames[4] = PlayerName5.text
        PlayerNames[5] = PlayerName6.text
        PlayerNames[6] = PlayerName7.text
        def.setObject(PlayerNames, forKey: "PlayerNames")
        def.synchronize()
        println(PlayerNames)
        
        //役職決定
        RoleSet()
        
        //画面遷移用
        let RoleVC : RoleViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RoleVC") as! RoleViewController
        self.navigationController?.pushViewController(RoleVC, animated: true)
        
    }
    
    /////////////////新規関数///////////////////
    func firstRun(){
        //TextViewにUserDefaultsから読み込んだプレイヤーネーム表示
        let def = NSUserDefaults.standardUserDefaults()
        var PlayerNames:[NSString] = def.objectForKey("PlayerNames") as! [NSString]
                PlayerName1.text = PlayerNames[0] as String
                PlayerName2.text = PlayerNames[1] as String
                PlayerName3.text = PlayerNames[2] as String
                PlayerName4.text = PlayerNames[3] as String
                PlayerName5.text = PlayerNames[4] as String
                PlayerName6.text = PlayerNames[5] as String
                PlayerName7.text = PlayerNames[6] as String
        //プレイ人数毎にTextFieldの表示切り替え
        switch def.objectForKey("PlayerNum") as! Int{
        case 3:
            for(var i=0; i<7; i++){
                if(i > 2){
                    PNTextViews[i].hidden = true
                }else{
                    PNTextViews[i].hidden = false
                }
            }
            break
        case 4:
            for(var i=0; i<7; i++){
                if(i > 3){
                    PNTextViews[i].hidden = true
                }else{
                    PNTextViews[i].hidden = false
                }
            }
            break
        case 5:
            for(var i=0; i<7; i++){
                if(i > 4){
                    PNTextViews[i].hidden = true
                }else{
                    PNTextViews[i].hidden = false
                }
            }
            break
        case 6:
            for(var i=0; i<7; i++){
                if(i > 5){
                    PNTextViews[i].hidden = true
                }else{
                    PNTextViews[i].hidden = false
                }
            }
            break
        case 7:
            for(var i=0; i<7; i++){
                if(i > 6){
                    PNTextViews[i].hidden = true
                }else{
                    PNTextViews[i].hidden = false
                }
            }
            break
        default:
            break
        }
    }
    
    //役職抽選
    //
    //     てるてる有り -> 0~4でランダム
    //　　　てるてる無し -> 0~3でランダム
    //      村人:0 人狼:1 占い師:2 怪盗:3 てるてる:4
    // 3人て有: 1     1                    1
    // 4人て有: 1     2                    1
    // 5人て有: 2     2                    1
    // 6人て有: 3     2                    1
    // 7人て有: 4     2                    1
    // 3人て無: 1     2                    0
    // 4人て無: 2     2                    0
    // 5人て無: 3     2                    0
    // 6人て無: 4     2                    0
    // 7人て無: 5     2                    0
    //
    
    var Mura=0, Jinro=0, Uranai=1, Kaito=1, Teru=0
    func RoleSet(){
        
        let def = NSUserDefaults.standardUserDefaults()
        var PlayerRoles:[NSString] = def.objectForKey("PlayerRoles") as! [NSString]
        //カード枚数設定
        Card()
        var CardNum :[Int] = [Mura,Jinro,Uranai,Kaito,Teru]
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.CardNum = CardNum
        
        //プレイ人数の回数繰り返し
       // for (var i=1; i<def.objectForKey("PlayerNum") as! Int; i++){
        var i = 0;
        while(i < def.objectForKey("PlayerNum") as! Int){
            var randNum = Rand()
           // println(randNum)
           // println("村=\(Mura), 人狼=\(Jinro), 占い=\(Uranai), 怪盗=\(Kaito), てるてる=\(Teru)")
            
            switch randNum{
            case 0:
                if(Mura != 0){
                    PlayerRoles[i] = "村人"
                    Mura--
                    i++
                }
                break
            case 1:
                if(Jinro != 0){
                    PlayerRoles[i] = "人狼"
                    Jinro--
                    i++
                }
                break
            case 2:
                if(Uranai != 0){
                    PlayerRoles[i] = "占い師"
                    Uranai--
                    i++
                }
                break
            case 3:
                if(Kaito != 0){
                    PlayerRoles[i] = "怪盗"
                    Kaito--
                    i++
                }
                break
            case 4:
                if(Teru != 0){
                    PlayerRoles[i] = "てるてる"
                    Teru--
                    i++
                }
                break
            default:
                break
            }
            
        }
        println("余り: 村=\(Mura), 人狼=\(Jinro), 占い=\(Uranai), 怪盗=\(Kaito), てるてる=\(Teru)")
        println(PlayerRoles)
        
        var LeftCards:[Int] = [Mura,Jinro,Uranai,Kaito,Teru]
        def.setObject(PlayerRoles, forKey: "PlayerRoles")
        def.setObject(PlayerRoles, forKey: "PlayerRolesTraded")
        def.setObject(LeftCards, forKey: "LeftCards")
        def.synchronize()

    }
    
    //カード枚数設定
    func Card(){
        let def = NSUserDefaults.standardUserDefaults()
        switch def.objectForKey("PlayerNum") as! Int{
        case 3:
            if(def.objectForKey("isTeruTeru") as! Bool){
                Mura=1
                Jinro=1
                Teru=1
                Uranai=1
                Kaito=1
            }else{
                Mura=1
                Jinro=2
                Teru=0
                Uranai=1
                Kaito=1
            }
            break
        case 4:
            if(def.objectForKey("isTeruTeru") as! Bool){
                Mura=1
                Jinro=2
                Teru=1
                Uranai=1
                Kaito=1
            }else{
                Mura=2
                Jinro=2
                Teru=0
                Uranai=1
                Kaito=1
            }
            break
        case 5:
            if(def.objectForKey("isTeruTeru") as! Bool){
                Mura=2
                Jinro=2
                Teru=1
                Uranai=1
                Kaito=1
            }else{
                Mura=3
                Jinro=2
                Teru=0
                Uranai=1
                Kaito=1
            }
            break
        case 6:
            if(def.objectForKey("isTeruTeru") as! Bool){
                Mura=3
                Jinro=2
                Teru=1
                Uranai=1
                Kaito=1
            }else{
                Mura=4
                Jinro=2
                Teru=0
                Uranai=1
                Kaito=1
            }
            break
        case 7:
            if(def.objectForKey("isTeruTeru") as! Bool){
                Mura=4
                Jinro=2
                Teru=1
                Uranai=1
                Kaito=1
            }else{
                Mura=5
                Jinro=2
                Teru=0
                Uranai=1
                Kaito=1
            }
            break
        default:
            break
        }

    }
    //ランダム変数生成関数
    func Rand()->UInt32{
        let def = NSUserDefaults.standardUserDefaults()
        //てるてるの判定後ランダム変数生成
        if(def.objectForKey("isTeruTeru") as! Bool){
            var randInt = arc4random_uniform(5)
            return randInt
        }else{
            var randInt = arc4random_uniform(4)
            return randInt
        }

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

