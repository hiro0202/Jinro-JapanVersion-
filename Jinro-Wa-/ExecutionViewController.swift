//
//  ExecutionViewController.swift
//  OneNightJinroInCar
//
//  Created by OtsukaHiromichi on 2015/06/07.
//  Copyright (c) 2015年 OtsukaHiromichi. All rights reserved.
//

import UIKit

class ExecutionViewController: UIViewController {
    
    @IBOutlet weak var RoleImageView: UIImageView!
    @IBOutlet var Buttons: [UIButton]!
    @IBOutlet weak var ExeText1: UILabel!
    @IBOutlet weak var ExeText2: UILabel!
    @IBOutlet weak var ExeText3: UILabel!
    
    var executionList : [Int] = []
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ExeText2.hidden = true
        ExeText3.hidden = true
        firstRun()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /////////////////アクション///////////////////
    
    @IBAction func BtnAction(sender: AnyObject) {
        let def = NSUserDefaults.standardUserDefaults()
        var PlayerRoles:[NSString] = def.objectForKey("PlayerRoles") as! [NSString]
        var PlayerNames:[NSString] = def.objectForKey("PlayerNames") as! [NSString]

        if(executionList.isEmpty){
            executionList.append(sender.tag)
            ExeText1.text = PlayerNames[sender.tag] as String
            counter++
        }else if(!ExeText2.hidden && counter==1){
            executionList.append(sender.tag)
            ExeText2.text = PlayerNames[sender.tag] as String
            counter++
        }else if(!ExeText3.hidden && counter==2){
            executionList.append(sender.tag)
            ExeText3.text = PlayerNames[sender.tag] as String
            counter++
        }
    }
    
    
    
    @IBAction func CancelBtn(sender: AnyObject) {
        executionList = []
        ExeText1.text = "1."
        ExeText2.text = "2."
        ExeText3.text = "3."
        counter = 0
    }
    
    
    @IBAction func FinishBtn(sender: AnyObject) {
        //アラート表示
        let def = NSUserDefaults.standardUserDefaults()
            let alertController = UIAlertController(title: "確認", message: "選択終了しますか？", preferredStyle: .Alert)
            let otherAction = UIAlertAction(title: "はい", style: .Default) {
                action in def.setObject(self.executionList, forKey: "ExecutionList")
                let secondVC: ResultViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ResultVC") as! ResultViewController
                self.navigationController?.pushViewController(secondVC, animated: true)
            }
            let cancelAction = UIAlertAction(title: "いいえ", style: .Cancel) {
                action in
            }

            alertController.addAction(otherAction)
            alertController.addAction(cancelAction)
            presentViewController(alertController, animated: true, completion: nil)
        
    }
     /////////////////新規関数///////////////////
    func firstRun(){
        let def = NSUserDefaults.standardUserDefaults()
        var PlayerRoles:[NSString] = def.objectForKey("PlayerRoles") as! [NSString]
        var PlayerNames:[NSString] = def.objectForKey("PlayerNames") as! [NSString]
        
        for(var i=0; i<7; i++){
            Buttons[i].hidden = true
        }
        
        for(var i=0; i<def.objectForKey("PlayerNum")as! Int; i++){
            Buttons[i].hidden = false
            Buttons[i].setTitle(PlayerNames[i] as String, forState: UIControlState.Normal)
            if(i > 2){
                ExeText2.hidden = false
            }
            
            if(i > 4){
                ExeText3.hidden = false
            }
        }   
    }
}

