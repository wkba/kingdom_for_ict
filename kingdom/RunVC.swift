//
//  RunVC.swift
//  kingdom
//
//  Created by wakabashi on 2016/06/25.
//  Copyright © 2016年 wakabayashi. All rights reserved.
//

import UIKit

class RunVC: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
    
    
}

