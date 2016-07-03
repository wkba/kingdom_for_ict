//
//  scroll_custom.swift
//  kingdom
//
//  Created by wakabashi on 2016/07/03.
//  Copyright © 2016年 wakabayashi. All rights reserved.
//
import UIKit

@IBDesignable
class scroll_custom: UIScrollView {
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
}