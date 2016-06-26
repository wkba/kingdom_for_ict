//
//  TopVC.swift
//  kingdom
//
//  Created by wakabashi on 2016/06/25.
//  Copyright © 2016年 wakabayashi. All rights reserved.
//

import UIKit

class TopVC: UIViewController {
    
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        startButton.layer.borderColor = UIColor.whiteColor().CGColor
//        startButton.layer.borderWidth = 3
//        startButton.layer.cornerRadius = 3
//        startButton.layer.masksToBounds = true
        setButton(startButton)
        setButton(aboutButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setButton(button:UIButton!){
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
    }
    
}