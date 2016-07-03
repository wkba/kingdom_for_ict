//
//  PeripheralManager.swift
//  kingdom
//
//  Created by wakabashi on 2016/07/02.
//  Copyright © 2016年 wakabayashi. All rights reserved.
//

import CoreBluetooth
import CoreLocation
import UIKit


class PeripheralManager: CBPeripheralManager {
    
    private static let sharedInstance = PeripheralManager()
    private let beaconIdentifier = "ffff"
    private let uuidString = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
    var major = 1
    var minor = 1
    
    /**
     ペリフェラルとしてアドバタイジングを開始する
     */
    static func startAdvertising() {
        // delegateに代入すると CBPeripheralManagerDelegate のメソッドが呼び出される
        sharedInstance.delegate = sharedInstance
    }
//    init(major:Int, minor:Int){
//        self.major = major
//        self.minor = minor
//    }
    func setValues(){
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.major = (appDelegate.team_number)!
        self.minor = (appDelegate.position_number)!
    }
    func stopAdvertising(manager: CBPeripheralManager) {
        manager.stopAdvertising()
    }
}


// MARK: - CBPeripheralManagerDelegate

extension PeripheralManager: CBPeripheralManagerDelegate {
    
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .Unknown:
            print("Unknown")
        case .Resetting:
            print("Resetting")
        case .Unsupported:
            print("Unsupported")
        case .Unauthorized:
            print("Unauthorized")
        case .PoweredOff:
            print("PoweredOff")
        case .PoweredOn:
            print("PoweredOn")
            startAdvertisingWithPeripheralManager(peripheral)
        }
    }
    
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
        if let error = error {
            print("Failed to start advertising with error:\(error)")
        } else {
            print("Start advertising")
        }
    }
    
    /**
     ペリフェラルとしてアドバタイジングを開始する
     
     - parameter manager: CBPeripheralManagerDelegate から受け取れる CBPeripheralManager
     */
    private func startAdvertisingWithPeripheralManager(manager: CBPeripheralManager) {
        guard let proximityUUID = NSUUID(UUIDString: uuidString) else {
            return
        }
        setValues()
        print("自分のmajorは" + String(major) + "  minorは" + String(minor) )
        let beaconRegion = CLBeaconRegion(proximityUUID: proximityUUID, major: UInt16(major), minor: UInt16(minor), identifier: beaconIdentifier)
        let beaconPeripheralData: NSDictionary = beaconRegion.peripheralDataWithMeasuredPower(nil)
        manager.startAdvertising(beaconPeripheralData as? [String: AnyObject])
    }
    
}
