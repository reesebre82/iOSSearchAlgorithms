//
//  Bar.swift
//  Sorting
//
//  Created by Brendan Reese on 12/18/19.
//  Copyright © 2019 BrendanReese. All rights reserved.
//

import UIKit

class Bar{
    
    private var physicalView:UIView
    private var value: Int
    
    init(width: CGFloat, height: CGFloat){
        physicalView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        physicalView.backgroundColor = UIColor.white
        physicalView.layer.borderWidth = 1.0
        physicalView.layer.borderColor = UIColor.black.cgColor
        
        value = Int(height)
    }
    
    func center(point: CGPoint){
        physicalView.center = point
    }
    
    func origin(point: CGPoint){
        physicalView.frame = CGRect(x: point.x, y: point.y, width: physicalView.frame.width, height: physicalView.frame.height)
    }
    
    func setColor(color: UIColor){
        physicalView.backgroundColor = color
    }
    
    func getView() -> UIView{
        return physicalView
    }
    
    func getValue() -> Int{
        return value
    }
    
    func getOrigin() -> CGPoint{
        return CGPoint(x: physicalView.frame.minX, y: physicalView.frame.minY)
    }
}
