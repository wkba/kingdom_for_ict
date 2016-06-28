//
//  RunVC.swift
//  kingdom
//
//  Created by wakabashi on 2016/06/25.
//  Copyright © 2016年 wakabayashi. All rights reserved.
//

import UIKit

class RunVC: UIViewController {
    
    @IBOutlet weak var least_time: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    var countNum = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(RunVC.update), userInfo: nil, repeats: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func moveToActionVC(){
        let VC = self.storyboard!.instantiateViewControllerWithIdentifier( "ActionVC" )
        self.presentViewController( VC, animated: true, completion: nil)
    }
    
    func chageStatus(){
        statusLabel.text="もうすぐはじまります。"
    }
    func update() {
        if(countNum <= 0){
            moveToActionVC()
        }else{
            least_time.text = String(countNum)
            countNum -= 1
        }
    }
}

