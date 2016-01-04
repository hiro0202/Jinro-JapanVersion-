//
//  ActionViewController.swift
//  OneNightJinroInCar
//
//  Created by OtsukaHiromichi on 2015/06/07.
//  Copyright (c) 2015年 OtsukaHiromichi. All rights reserved.
//


import UIKit

class ActionViewController: UIViewController {
    //フラグ関係
    var Counter = 0;
    var Status = 0;
    var Finflag = false;
    
    //Outlet
    @IBOutlet weak var RoleImageView: UIImageView!
    @IBOutlet weak var Btn1: UIButton!
    @IBOutlet weak var Btn2: UIButton!
    @IBOutlet weak var Btn3: UIButton!
    @IBOutlet weak var Btn4: UIButton!
    @IBOutlet weak var Btn5: UIButton!
    @IBOutlet weak var Btn6: UIButton!
    @IBOutlet weak var Btn7: UIButton!
    @IBOutlet var Buttons: [UIButton]!
    @IBOutlet weak var DoneBtn: UIButton!
    @IBOutlet weak var JinroView: UIView!
    @IBOutlet weak var JinroText: UILabel!
    @IBOutlet weak var UranaiView1: UIImageView!
    @IBOutlet weak var UranaiView2: UIImageView!
    
    //配列
    var UranaiTemp :[Int] = []
    var KaitoTemp :[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        Counter = appDelegate.Counter!
        Status = 0;
        Finflag = false;
        RoleImageView.hidden = false
        UranaiView1.hidden = true
        UranaiView2.hidden = true

        setImage(-1)
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /////////////////アクション///////////////////
    
    @IBAction func DoneBtn(sender: AnyObject) {
        let def = NSUserDefaults.standardUserDefaults()
        if(Finflag){
            if(Counter + 1 != def.objectForKey("PlayerNum") as! Int){
                    self.navigationController?.popViewControllerAnimated(true)
            }else{
                let secondVC: TImerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TimerVC") as! TImerViewController
                self.navigationController?.pushViewController(secondVC, animated: true)
            }

        }
    }
    /////////////////新規関数///////////////////
    func setImage(num : Int){
        let temp = Counter

        
        let def = NSUserDefaults.standardUserDefaults()
        var PlayerRoles:[NSString] = def.objectForKey("PlayerRoles") as! [NSString]
        JinroView.hidden = true
        
        if(num == -1){
            if(PlayerRoles[Counter] as NSString == "村人"){
                RoleImageView.image = UIImage(named: "people.png")
                Status = 0;
                Finflag = true
                ButtonsHide()
            }else if(PlayerRoles[Counter] as NSString == "人狼"){
                RoleImageView.image = UIImage(named: "jinro.png")
                Status = 1;
                setJinroText()
                Finflag = true
                JinroView.hidden = false
                ButtonsHide()
            }else if(PlayerRoles[Counter] as NSString == "占い師"){
                RoleImageView.image = UIImage(named: "uranai.png")
                Status = 2;
                ButtonsSet()
            }else if(PlayerRoles[Counter] as NSString == "怪盗"){
                RoleImageView.image = UIImage(named: "theaf.png")
                Status = 3;
                ButtonsSet()
            }else if(PlayerRoles[Counter] as NSString == "てるてる"){
                RoleImageView.image = UIImage(named: "teruteru.png")
                Status = 0;
                Finflag = true
                ButtonsHide()
            }
        }else{
            Counter = num
            if(PlayerRoles[Counter] as NSString == "村人"){
                RoleImageView.image = UIImage(named: "people.png")
            }else if(PlayerRoles[Counter] as NSString == "人狼"){
                RoleImageView.image = UIImage(named: "jinro.png")
            }else if(PlayerRoles[Counter] as NSString == "占い師"){
                RoleImageView.image = UIImage(named: "uranai.png")
            }else if(PlayerRoles[Counter] as NSString == "怪盗"){
                RoleImageView.image = UIImage(named: "theaf.png")
            }else if(PlayerRoles[Counter] as NSString == "てるてる"){
                if(Status != 2){
                    RoleImageView.image = UIImage(named: "teruteru.png")
                }else{
                    RoleImageView.image = UIImage(named: "people.png")
                }
            }

        }
        Counter = temp
    }
    //ボタンを全て隠す
    func ButtonsHide(){
        for(var i=0; i<7; i++){
            Buttons[i].hidden = true
        }
    }
    //ボタンを表示して名前設定
    func ButtonsSet(){
        ButtonsHide()
        let def = NSUserDefaults.standardUserDefaults()
        var PlayerRoles:[NSString] = def.objectForKey("PlayerRoles") as! [NSString]
        var PlayerNames:[NSString] = def.objectForKey("PlayerNames") as! [NSString]

        var j = 0;
        for(var i=0; i<def.objectForKey("PlayerNum")as! Int; i++){
            Buttons[i].hidden = false
            if(Status == 2){
            //占い師のとき
                if(PlayerRoles[i] as NSString != "占い師"){
                    Buttons[j].setTitle(PlayerNames[i] as String, forState: UIControlState.Normal)
                    UranaiTemp.append(i)
                }else{
                    j--
                    if(j < 0 && i != 0){
                        j=0
                    }
                }
            }else if(Status == 3){
            //怪盗のとき
                if(PlayerRoles[i] as NSString != "怪盗"){
                    Buttons[j].setTitle(PlayerNames[i] as String, forState: UIControlState.Normal)
                    KaitoTemp.append(i)
                }else{
                    j--
                    if(j < 0 && i != 0){
                        j=0
                    }
                }
            }
            j++
        }
        if(Status == 3){
            Buttons[j].hidden = true
        }
        if(Status == 2){
            Buttons[j].setTitle("余ったカード", forState: UIControlState.Normal)
        }
    }
    
    
    ////////////////////////人狼用関数////////////////////////////
    func setJinroText(){
        let def = NSUserDefaults.standardUserDefaults()
        var PlayerRoles:[NSString] = def.objectForKey("PlayerRoles") as! [NSString]
        var PlayerNames:[NSString] = def.objectForKey("PlayerNames") as! [NSString]
        var jinro1 = -1, jinro2 = -1
        
        for(var i=0; i<def.objectForKey("PlayerNum")as! Int; i++){
            if(PlayerRoles[i] as NSString == "人狼"){
                if(jinro1 == -1){
                    jinro1=i
                }else{
                    jinro2=i
                }
            }
        }
        if(jinro2 == -1){
            JinroText.text = "他に猛虎の気配は無いようだ..."
        }else{
            if(jinro1 != Counter){
                JinroText.text = PlayerNames[jinro1] as String + "から仲間の気配がする..."
            }else{
                JinroText.text = PlayerNames[jinro2] as String + "から仲間の気配がする..."
            }
            
        }
        
    }
     ////////////////////////占い師・怪盗共通////////////////////////////
    @IBAction func BtnAction(sender: AnyObject) {
         let def = NSUserDefaults.standardUserDefaults()
        //占い師の場合
        if(Status == 2 && !Finflag){
            if(def.objectForKey("PlayerNum")as! Int != sender.tag+1){
                setImage(UranaiTemp[sender.tag])
                Finflag = true
            }else{
                RoleImageView.hidden = true
                UranaiView1.hidden = true
                UranaiView2.hidden = false
                var LeftCards:[Int] = def.objectForKey("LeftCards") as! [Int]
                for(var i=0; i < 5; i++){
                    if(LeftCards[i] > 0){
                        switch i {
                        case 0:
                            if(UranaiView1.hidden){
                                UranaiView1.hidden = false
                                UranaiView1.image = UIImage(named: "people.png")
                                i--
                            }else{
                                UranaiView2.image = UIImage(named: "people.png")
                            }
                            break
                        case 1:
                            if(UranaiView1.hidden){
                                UranaiView1.hidden = false
                                UranaiView1.image = UIImage(named: "jinro.png")
                                i--
                            }else{
                                UranaiView2.image = UIImage(named: "jinro.png")
                            }
                            break
                        case 2:
                            break
                        case 3:
                            if(UranaiView1.hidden){
                                UranaiView1.hidden = false
                                UranaiView1.image = UIImage(named: "theaf.png")
                                i--
                            }else{
                                UranaiView2.image = UIImage(named: "theaf.png")
                            }
                            break
                        case 4 :
                            if(UranaiView1.hidden){
                                UranaiView1.hidden = false
                                UranaiView1.image = UIImage(named: "teruteru.png")
                                i--
                            }else{
                                UranaiView2.image = UIImage(named: "teruteru.png")
                            }
                            break
                        default :
                            break
                        }
                    }
                }
                Finflag = true
            }
        //怪盗の場合
        }else if(Status == 3){
            if(!Finflag){
                var PlayerRoles:[NSString] = def.objectForKey("PlayerRoles") as! [NSString]
                var PlayerNames:[NSString] = def.objectForKey("PlayerNames") as! [NSString]
                setImage(KaitoTemp[sender.tag])
                
                //カード交換
                PlayerRoles[Counter] = PlayerRoles[KaitoTemp[sender.tag]]
                PlayerRoles[KaitoTemp[sender.tag]] = "怪盗"
                
                def.setObject(PlayerRoles, forKey: "PlayerRolesTraded")
                def.synchronize()
                
                println("交換後:\(PlayerRoles)")
                let alert = UIAlertView()
                alert.title = "確認"
                
                var rolename = ""
                
                if(PlayerRoles[Counter] as NSString == "村人"){
                    rolename = "町娘"
                }else if(PlayerRoles[Counter] as NSString == "人狼"){
                    rolename = "猛虎"
                }else if(PlayerRoles[Counter] as NSString == "占い師"){
                    rolename = "侍"
                }else if(PlayerRoles[Counter] as NSString == "怪盗"){
                    rolename = "歌舞伎者"
                }else if(PlayerRoles[Counter] as NSString == "てるてる"){
                    rolename = "貘"
                }

                
                alert.message = "\(PlayerNames[KaitoTemp[sender.tag]])の\(rolename)と交換しました"
                alert.addButtonWithTitle("OK")
                alert.show()
                Finflag = true
            }
        }
    }

}

