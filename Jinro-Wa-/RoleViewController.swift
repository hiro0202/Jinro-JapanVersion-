//
//  RoleViewController.swift
//  OneNightJinroInCar
//
//  Created by OtsukaHiromichi on 2015/06/06.
//  Copyright (c) 2015年 OtsukaHiromichi. All rights reserved.
//
import UIKit

class RoleViewController: UIViewController {
    var Counter = 0;
    
    @IBOutlet weak var RoleImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //カードを裏返しに
        RoleImageView.image = UIImage(named:"cardback.png")
        let def = NSUserDefaults.standardUserDefaults()
        var PlayerNames:[NSString] = def.objectForKey("PlayerNames") as! [NSString]
        
        //アラート表示
        print(Counter)
        if(Counter < (def.objectForKey("PlayerNum") as! Int)){
            let alertController = UIAlertController(title: "確認", message: "あなたは\(PlayerNames[Counter] as NSString)ですか？", preferredStyle: .Alert)
            let otherAction = UIAlertAction(title: "はい", style: .Default) {
                //カード画像設定
                action in self.setImage()
            }
            alertController.addAction(otherAction)
            presentViewController(alertController, animated: true, completion: nil)
            
        }else{
            //話し合い画面へ遷移
            print("行動終了")
        }
    }
    
    /////////////////アクション///////////////////
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func DoneBtn(sender: AnyObject) {
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.Counter = Counter
        
        Counter++
        //StoryBoardのIdentiferからViewControllerを作ってShow
        let secondVC: ActionViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ActionVC") as! ActionViewController
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    
    /////////////////新規関数///////////////////
    //Counterを使って現在のプレイヤーの役職カード表示
    func setImage(){
        let def = NSUserDefaults.standardUserDefaults()
        var PlayerRoles:[NSString] = def.objectForKey("PlayerRoles") as! [NSString]
        
        if(PlayerRoles[Counter] as NSString == "村人"){
            RoleImageView.image = UIImage(named: "people.png")
        }else if(PlayerRoles[Counter] as NSString == "人狼"){
            RoleImageView.image = UIImage(named: "jinro.png")
        }else if(PlayerRoles[Counter] as NSString == "占い師"){
            RoleImageView.image = UIImage(named: "uranai.png")
        }else if(PlayerRoles[Counter] as NSString == "怪盗"){
            RoleImageView.image = UIImage(named: "theaf.png")
        }else if(PlayerRoles[Counter] as NSString == "てるてる"){
            RoleImageView.image = UIImage(named: "teruteru.png")
        }
        
    
        
    }
}

