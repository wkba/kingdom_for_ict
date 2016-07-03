//
//  WaitVC.swift
//  kingdom
//
//  Created by wakabashi on 2016/06/25.
//  Copyright © 2016年 wakabayashi. All rights reserved.
//

import UIKit
import Firebase

class WaitVC: UIViewController{
    
    @IBOutlet weak var startButton: UIButton!

    @IBAction func updateJoin(sender: AnyObject) {
        if(isJoin == true){
            ref.setValue(String(Int(person_label.text!)! - 1))
            isJoin = false
            self.startButton.hidden = true
            self.joinButton.setTitle("参加する", forState: UIControlState.Normal)
        }else{
            self.myNumber = Int(person_label.text!)!
            ref.setValue(String(Int(person_label.text!)! + 1))
            isJoin = true
            self.startButton.hidden = false
            self.joinButton.setTitle("キャンセルする", forState: UIControlState.Normal)
        }
    }
    @IBAction func goRunVC(sender: AnyObject) {
        saveValues(self.myNumber)
    }
    @IBOutlet weak var person_label: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    //ルーム作成のためのCLLocationManagerのマネージャーと緯度、経度
    var isJoin = false
    var RoomID:String = "123456"
    //var RoomID:String = "error"
    var uuid:String = "error"
    var ref = Firebase(url:"https://ict-kingdom.firebaseio.com/")
    var myNumber:Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setButton(startButton)
        setButton(joinButton)

        ref.observeEventType(.Value, withBlock: {
            snapshot in
            self.person_label.text = snapshot.value as? String
            self.joinButton.hidden = false
        })
        
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
        RoomID = (appDelegate.RoomID)!
        print("roomID is \(RoomID)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setButton(button:UIButton!){
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
    }
    func saveValues (num:Int){
        print("My number is " + String(num))
        let team_arr = ["魏","呉","蜀"]
        let position_arr = ["王","軍師","武士","平民"]
        let team_num = Int(num) % 3
        let team_name = team_arr[team_num]
        
        var position_num = Int(num) / 3
        if(position_num > 2){
            position_num = 3
        }
        let position_name = position_arr[position_num]
        
        
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.team_name = team_name
        appDelegate.team_number = team_num
        appDelegate.position_name = position_name
        appDelegate.position_number = position_num
        // print(appDelegate.team_name! +  appDelegate.position_name!)
    }
    
}

