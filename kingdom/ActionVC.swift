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


class ActionVC: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var statusLabel: UILabel!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValues()
        // startAdvertising
        PeripheralManager.startAdvertising()
        
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startRangingBeaconsInRegion(region)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.team_num = (appDelegate.team_number)!
        self.team_name = (appDelegate.team_name)!
        self.position_num = (appDelegate.position_number)!
        self.position_name = (appDelegate.position_name)!
        print("自分は" + self.team_name + "の" + self.position_name)
    }
    
}

