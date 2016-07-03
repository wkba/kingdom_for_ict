//
//  ActionVC.swift
//  kingdom
//
//  Created by wakabashi on 2016/06/25.
//  Copyright © 2016年 wakabayashi. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth
import Firebase



class ActionVC: UIViewController,CLLocationManagerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var iconImageButton: UIButton!
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "Estimotes")
    // Note: make sure you replace the keys here with your own beacons' Minor Values
//    let colors = [
//        UIColor(red: 84/255, green: 77/255, blue: 160/255, alpha: 1),
//        UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1),
//        UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1)
//    ]
    var isWin = false
    var isLose = false
    var team_num = 999
    var team_name = "error"
    var position_num = 999
    var position_name = "error"
    var isEnd = false
    var message = ""
    var RoomID:String = "123456"
    var uuid:String = "error"
    var ref = Firebase(url:"https://ict-kingdom.firebaseio.com/chat")
    
    @IBAction func textDieldDidEndOnExit(sender: UITextField) {
        //let message = message_field.text
        //print(message)
    }
    @IBOutlet weak var message_field: UITextField!
    @IBAction func send_message_button(sender: AnyObject) {
        let pre =  message_area_label.text! + "\n"
        let now = "   \(position_name):   \(self.message)"
//        message_area_label.text = pre + now
          ref.setValue(pre + now)

    }
    @IBOutlet weak var message_area_label: UILabel!
    @IBOutlet weak var message_area: scroll_custom!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref.observeEventType(.Value, withBlock: {
            snapshot in
            self.message_area_label.text = snapshot.value as? String
        })
        
        message_field.delegate = self
        message_area_label.sizeToFit()
        setValues()
        // startAdvertising
        //PeripheralManager.startAdvertising()
        
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startRangingBeaconsInRegion(region)
        
        //let img:UIImage = UIImage(named:"icon[0][0].png")!
        //self.myImage = UIImageView(image:img)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        //UIScrollBar表示時にスクロールバーをフラッシュ表示
        message_area.flashScrollIndicators()
    }
    

    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        if (isEnd == false){
            let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
            if (knownBeacons.count > 0) {
                let closestBeacon = knownBeacons[0] as CLBeacon
                print("相手のmajorは" + String(closestBeacon.major) + "  minorは" + String(closestBeacon.minor) )
                judgeState(Int(closestBeacon.major),target_position_number: Int(closestBeacon.minor))
            }
        }
    }
    
    func moveToWinVC(){
        let VC = self.storyboard!.instantiateViewControllerWithIdentifier( "WinVC" )
        self.presentViewController( VC, animated: true, completion: nil)
    }
    func moveToLoseVC(){
        let VC = self.storyboard!.instantiateViewControllerWithIdentifier( "LoseVC" )
        self.presentViewController( VC, animated: true, completion: nil)
    }
    
    func judgeState(target_team_number:Int, target_position_number:Int){
        if(self.team_num == target_team_number){
            //味方
            print("味方。相手は" + String(target_team_number) + String(target_team_number))
        }else if( (self.team_num + 1) % 3 == target_team_number){
            //勝つ
            print("勝った。相手は" + String(target_team_number) + String(target_team_number))
            moveToWinVC()
            self.isEnd = true
        }else if( (self.team_num + 2) % 3 == target_team_number){
            //負ける
            print("負けた。相手は" + String(target_team_number) + String(target_team_number))
            moveToLoseVC()
            self.isEnd = true
        }
    }
    
    func setValues(){
//        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        self.team_num = (appDelegate.team_number)!
//        self.team_name = (appDelegate.team_name)!
//        self.position_num = (appDelegate.position_number)!
//        self.position_name = (appDelegate.position_name)!
        ref.setValue("")
        self.team_num = 1
        self.team_name = "呉"
        self.position_num = 1
        self.position_name = "軍師"
        let iconImage:UIImage = UIImage(named: "icon[" + String(self.team_num) + "][" + String(self.position_num) + "].png")!;
        self.iconImageButton.setBackgroundImage(iconImage, forState: UIControlState.Normal);
        self.statusLabel.text = "team: \(self.team_name)\nposition: \(self.position_name)"
        
        print("自分は" + self.team_name + "の" + self.position_name)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        
        self.message = message_field.text!
        print(self.message)
        // キーボードを閉じる
        textField.resignFirstResponder()

        return true
    }
    
}

