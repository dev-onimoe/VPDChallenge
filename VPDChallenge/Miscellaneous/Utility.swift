//
//  Utility.swift
//  VPDChallenge
//
//  Created by Masud Onikeku on 21/06/2024.
//

import Foundation
import UIKit

public var backView = UIView()
var appdelegate = UIApplication.shared.delegate as! AppDelegate

func rotateAnimation(imageView:UIImageView,duration: CFTimeInterval = 2.0) {
    let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
    rotateAnimation.fromValue = 0.0
    rotateAnimation.toValue = CGFloat(.pi * 2.0)
    rotateAnimation.duration = duration
    rotateAnimation.repeatCount = Float.greatestFiniteMagnitude;
    imageView.layer.add(rotateAnimation, forKey: nil)
}

class Utility: NSObject {
    
    class func showProgressHUD(){
        for subUIView in backView.subviews as! [UIImageView] {
            subUIView.removeFromSuperview()
        }
        self.hideProgressHUD()
        //let window = appdelegate.window?.frame
        backView.frame =  CGRect(x: 0, y: 0, width:  appdelegate.window!.frame.size.width, height: appdelegate.window!.frame.size.height)
        backView.backgroundColor = UIColor.black.withAlphaComponent(0.30)
        let imgViewRing = UIImageView(image: UIImage(named: "loader"))
        imgViewRing.tintColor = .gray
        imgViewRing.removeFromSuperview()
        imgViewRing.contentMode = .scaleAspectFit
        imgViewRing.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        //    imgViewRing.frame = CGRect(x: 0, y: 0, width: backView.frame.size.width/6.0, height: backView.frame.size.width/6.0)
        imgViewRing.center = CGPoint(x: backView.frame.size.width/2.0, y: backView.frame.size.height/2.0)
        rotateAnimation(imageView: imgViewRing)
        backView.addSubview(imgViewRing)
        appdelegate.window?.addSubview(backView)
        //    actualView.view.addSubview(backView)
    }
    
    class func hideProgressHUD(){
        backView.removeFromSuperview()
        appdelegate.window?.setNeedsLayout()
        //appdelegate.window?.setNeedsLayout()
    }
}
