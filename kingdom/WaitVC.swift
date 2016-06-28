//
//  WaitVC.swift
//  kingdom
//
//  Created by wakabashi on 2016/06/25.
//  Copyright © 2016年 wakabayashi. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

class WaitVC: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var person_label: UILabel!

    @IBAction func updateJoin(sender: AnyObject) {
        if(isJoin == false){
            ref.setValue(String(Int(person_label.text!)! + 1))
            isJoin = true
            startButton.hidden = false
            self.joinButton.setTitle("キャンセルする", forState: UIControlState.Normal)
        }else{
            ref.setValue(String(Int(person_label.text!)! - 1))
            isJoin = false
            startButton.hidden = true
            self.joinButton.setTitle("参加する", forState: UIControlState.Normal)
        }
    }
    //ルーム作成のためのCLLocationManagerのマネージャーと緯度、経度
    var isJoin = false
    var lm: CLLocationManager!
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    //TODO: delete This is for demo
    var RoomID:String = "123456"
    //var RoomID:String = "error"
    var uuid:String = "error"
    var ref = Firebase(url:"https://ict-kingdom.firebaseio.com/")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setButton(startButton)
        setButton(joinButton)
        //ルーム作成のためのCLLocationManagerを作成、開始
        lm = CLLocationManager()
        lm.delegate = self
        lm.requestAlwaysAuthorization()
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.distanceFilter = 1000
        lm.startUpdatingLocation()

        ref.observeEventType(.Value, withBlock: {
            snapshot in
            self.person_label.text = snapshot.value as? String
            
        })
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
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation){
        latitude = newLocation.coordinate.latitude
        longitude = newLocation.coordinate.longitude
        //RoomIDとuuidを作成
        let latitude_Int = (Int)(latitude % 100) * 100 + (Int)(latitude * 100) % 100
        let longitude_Int = (Int)(longitude % 100) * 100 + (Int)(longitude * 100) % 100
//        RoomID = "\(latitude_Int)" + "\(longitude_Int)"
        RoomID = "123456"
        uuid = "aaaaaaaa-aaaa-aaaa-aaaa-aaaa-" + RoomID
        print(uuid)
        lm.stopUpdatingLocation()
    }
    // 位置情報取得に失敗した時に呼び出されるデリゲート.
    func locationManager(manager: CLLocationManager,didFailWithError error: NSError){
        print("error:位置情報取得に失敗した")
    }
    
    
}

