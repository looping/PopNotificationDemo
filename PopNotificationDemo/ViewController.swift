//
//  ViewController.swift
//  PopNotificationDemo
//
//  Created by Looping on 14/10/20.
//  Copyright (c) 2014年 Ridgecorn. All rights reserved.
//

import UIKit

class ATNotificationRemoveView: UIView {
    
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showButtonTouched(sender: UIButton) {
        self.showNotificationBox()
    }
    
    func showNotificationBox() {
        var items: [AnyObject]? = RCDraggableButton.itemsInView(nil)
        if items != nil {
            (items?.first as? RCDraggableButton)?.removeLighting()
            
            RCDraggableButton.removeAllFromView(nil)
        }
        
        var width: CGFloat = 60.0;
        var height: CGFloat = 60.0;
        var removeView: ATNotificationRemoveView = ATNotificationRemoveView()
        var frame: CGRect = self.view.frame
        frame.origin.y -= height
        frame.size.width = width
        removeView.frame = frame
        
        frame = self.view.frame
        frame.origin.x = frame.size.width / 2
        frame.origin.y = frame.size.height / 2
        frame.size.width = width
        frame.size.height = height
        var popNotification: RCDraggableButton? = RCDraggableButton(inView: nil, withFrame: frame)
        
        popNotification?.setTitle("L", forState: UIControlState.Normal)
        popNotification?.titleLabel?.font = UIFont.systemFontOfSize(32)
        popNotification?.backgroundColor = UIColor.blueColor()
        
        var avatar: UIImage? = UIImage(named: "avatar")
        
        popNotification?.setBackgroundImage(avatar, forState: UIControlState.Normal)
        popNotification?.layer.cornerRadius = width / 2
        popNotification?.layer.masksToBounds = true
        popNotification?.autoDocking = true
        
        popNotification?.showLighting()
        popNotification?.tapBlock = {(button) in
            println("tapped")
            popNotification?.removeLighting()
        }
        
        var animation: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        
        animation.fromValue = NSValue(CGPoint: CGPointMake(0.5, 0.5))
        
        animation.toValue = NSValue(CGPoint: CGPointMake(1.0, 1.0))
        
        animation.springBounciness = 20.0
        animation.springSpeed = 10.0
        
        popNotification?.layer.pop_addAnimation(animation, forKey: "kATShowNotificationAnimation")
    }
    
    @IBAction func closeButtonTouched(sender: UIButton) {
        var items: [AnyObject]? = RCDraggableButton.itemsInView(nil)
        if items != nil {
            var popNotification: RCDraggableButton? = items?.first as? RCDraggableButton
            
            var animation: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
            
            animation.fromValue = NSValue(CGPoint: CGPointMake(1.0, 1.0))
            
            animation.toValue = NSValue(CGPoint: CGPointMake(0.1, 0.1))
            
            animation.duration = 0.3
            
            animation.completionBlock = {(animation, finished) in
                popNotification?.removeLighting()

                RCDraggableButton.removeAllFromView(nil)
            }
            
            popNotification?.layer.pop_addAnimation(animation, forKey: "kATCloseNotificationAnimation")
        }
    }
}