//
//  ResultViewController.swift
//  OneNightJinroInCar
//
//  Created by OtsukaHiromichi on 2015/06/07.
//  Copyright (c) 2015年 OtsukaHiromichi. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var ExeImageViews: [UIImageView]!
    @IBOutlet var ExeTextViews: [UILabel]!
    @IBOutlet var PlayerImageViews: [UIImageView]!
    @IBOutlet var PlayerTextViews: [UILabel]!
    @IBOutlet var WinImages: [UIImageView]!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var WinState = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2)
        
        firstRun()
        
        checkWin()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func firstRun(){
        let def = NSUserDefaults.standardUserDefaults()
        var PlayerRoles:[NSString] = def.objectForKey("PlayerRoles") as! [NSString]
        var PlayerNames:[NSString] = def.objectForKey("PlayerNames") as! [NSString]
        var ExeLists:[Int] = def.objectForKey("ExecutionList") as! [Int]
        
        for(var i=0; i<3; i++){
            ExeTextViews[i].text = "無し"
        }
        
        if(!ExeLists.isEmpty){
            switch ExeLists.count {
            case 1:
                ExeImageViews[0].image = retImg(PlayerRoles[ExeLists[0]])
                ExeTextViews[0].text = PlayerNames[ExeLists[0]] as String
                break
            case 2:
                ExeImageViews[0].image = retImg(PlayerRoles[ExeLists[0]])
                ExeImageViews[1].image = retImg(PlayerRoles[ExeLists[1]])
                ExeTextViews[0].text = PlayerNames[ExeLists[0]] as String
                ExeTextViews[1].text = PlayerNames[ExeLists[1]] as String
                break
            case 3:
                ExeImageViews[0].image = retImg(PlayerRoles[ExeLists[0]])
                ExeImageViews[1].image = retImg(PlayerRoles[ExeLists[1]])
                ExeImageViews[2].image = retImg(PlayerRoles[ExeLists[2]])
                ExeTextViews[0].text = PlayerNames[ExeLists[0]] as String
                ExeTextViews[1].text = PlayerNames[ExeLists[1]] as String
                ExeTextViews[2].text = PlayerNames[ExeLists[2]] as String
                break
            default:
                break
            }
        }else{
 
        }
        
        for(var i=0; i<7; i++){
            PlayerImageViews[i].hidden = true
            PlayerTextViews[i].hidden = true
            WinImages[i].hidden = true
            
        }
        
        for(var i=0; i < def.objectForKey("PlayerNum") as! Int; i++){
            PlayerImageViews[i].hidden = false
            PlayerTextViews[i].hidden = false
            
            PlayerTextViews[i].text = PlayerNames[i] as String
            PlayerImageViews[i].image = retImg(PlayerRoles[i])
        }
        
    }
    
    //役職名からカード画像を返す
    func retImg(Role:NSString)->UIImage{
        if(Role == "村人"){
            return UIImage(named: "people.png")!
        }else if(Role == "人狼"){
           return UIImage(named: "jinro.png")!
        }else if(Role == "占い師"){
            return UIImage(named: "uranai.png")!
        }else if(Role == "怪盗"){
            return UIImage(named: "theaf.png")!
        }else if(Role == "てるてる"){
            return UIImage(named: "teruteru.png")!
        }else {
        return UIImage(named: "backimg.png")!
        }
    }
    
    //勝ち負けのチェックを行う関数
    func checkWin(){
        let def = NSUserDefaults.standardUserDefaults()
        var PlayerRoles:[NSString] = def.objectForKey("PlayerRoles") as! [NSString]
        var PlayerNames:[NSString] = def.objectForKey("PlayerNames") as! [NSString]
        var ExeLists:[Int] = def.objectForKey("ExecutionList") as! [Int]
        var WinPlayerLists:[NSString] = []
        
        //処刑者有り
        if(!ExeLists.isEmpty){
            switch ExeLists.count {
            case 1://一人の場合
                if(PlayerRoles[ExeLists[0]] as NSString == "てるてる"){//てるてる一人勝ち
                    WinState = 2
                    WinPlayerLists.append(PlayerNames[ExeLists[0]])
                    WinImages[ExeLists[0]].hidden = false
                }else if(PlayerRoles[ExeLists[0]] as NSString == "人狼"){//村人勝ち
                    for(var i=0; i<def.objectForKey("PlayerNum") as! Int; i++){
                        if(PlayerRoles[i] != "人狼" && PlayerRoles[i] != "てるてる"){
                            WinPlayerLists.append(PlayerNames[i])
                            WinImages[i].hidden = false
                        }
                        WinState = 0
                    }
                }else{//てるてるが居らず、人狼が一人も吊られなかった時
                    //人狼がいれば
                    for(var i=0; i<def.objectForKey("PlayerNum") as! Int; i++){
                        //人狼が勝ち
                        if(PlayerRoles[i] == "人狼"){
                            WinPlayerLists.append(PlayerNames[i])
                            WinImages[i].hidden = false
                            WinState = 1
                        }
                    }
                    //人狼が居なければ
                    if(WinState != 1){
                        WinState = 3
                    }
                }
                break
            case 2://二人の場合
                if(PlayerRoles[ExeLists[0]] as NSString == "てるてる"){//てるてる一人勝ち
                    WinState = 2
                    WinPlayerLists.append(PlayerNames[ExeLists[0]])
                    WinImages[ExeLists[0]].hidden = false
                }else if(PlayerRoles[ExeLists[1]] as NSString == "てるてる"){//てるてる一人勝ち
                    WinState = 2
                    WinPlayerLists.append(PlayerNames[ExeLists[1]])
                    WinImages[ExeLists[1]].hidden = false
                }else if(PlayerRoles[ExeLists[0]] as NSString == "人狼" || PlayerRoles[ExeLists[1]] as NSString == "人狼"){
                    for(var i=0; i<def.objectForKey("PlayerNum") as! Int; i++){
                        if(PlayerRoles[i] != "人狼" && PlayerRoles[i] != "てるてる"){
                            WinPlayerLists.append(PlayerNames[i])
                            WinImages[i].hidden = false
                        }
                        WinState = 0
                    }
                }else{
                    //人狼がいれば
                    for(var i=0; i<def.objectForKey("PlayerNum") as! Int; i++){
                        //人狼が勝ち
                        if(PlayerRoles[i] == "人狼"){
                            WinPlayerLists.append(PlayerNames[i])
                            WinImages[i].hidden = false
                            WinState = 1
                        }
                    }
                    //人狼が居なければ
                    if(WinState != 1){
                        WinState = 3
                    }
                }
                break
            case 3://三人の場合
                if(PlayerRoles[ExeLists[0]] as NSString == "てるてる"){//てるてる一人勝ち
                    WinState = 2
                    WinPlayerLists.append(PlayerNames[ExeLists[0]])
                    WinImages[ExeLists[0]].hidden = false
                }else if(PlayerRoles[ExeLists[1]] as NSString == "てるてる"){//てるてる一人勝ち
                    WinState = 2
                    WinPlayerLists.append(PlayerNames[ExeLists[1]])
                    WinImages[ExeLists[1]].hidden = false
                }else if(PlayerRoles[ExeLists[2]] as NSString == "てるてる"){//てるてる一人勝ち
                    WinState = 2
                    WinPlayerLists.append(PlayerNames[ExeLists[2]])
                    WinImages[ExeLists[2]].hidden = false
                }else if(PlayerRoles[ExeLists[0]] as NSString == "人狼" || PlayerRoles[ExeLists[1]] as NSString == "人狼"
                    || PlayerRoles[ExeLists[2]] as NSString == "人狼"){
                    for(var i=0; i<def.objectForKey("PlayerNum") as! Int; i++){
                        if(PlayerRoles[i] != "人狼" && PlayerRoles[i] != "てるてる"){
                            WinPlayerLists.append(PlayerNames[i])
                            WinImages[i].hidden = false
                        }
                        WinState = 0
                    }
                }else{
                    //人狼がいれば
                    for(var i=0; i<def.objectForKey("PlayerNum") as! Int; i++){
                        //人狼が勝ち
                        if(PlayerRoles[i] == "人狼"){
                            WinPlayerLists.append(PlayerNames[i])
                            WinImages[i].hidden = false
                            WinState = 1
                        }
                    }
                    //人狼が居なければ
                    if(WinState != 1){
                        WinState = 3
                    }
                }
                break
            default:
                break
            }
        //処刑者無し
        }else{
            //人狼がいれば
            for(var i=0; i<def.objectForKey("PlayerNum") as! Int; i++){
                //人狼が勝ち
                if(PlayerRoles[i] == "人狼"){
                    WinPlayerLists.append(PlayerNames[i])
                    WinImages[i].hidden = false
                    WinState = 1
                }
            }
            //人狼が居なければ
            if(WinState != 1){
                 for(var i=0; i<def.objectForKey("PlayerNum") as! Int; i++){
                    WinImages[i].hidden = false
                }
                WinState = 4
            }

        }
        
        
        print("WinState = \(WinState) 0:村人 1:人狼 2:てるてる 3:無駄死に 4:平和")
    }
    @IBAction func EndBtn(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}

