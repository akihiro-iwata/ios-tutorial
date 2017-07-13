//
//  UIActivityIndicatorView.swift
//  ios-tutorial
//
//  Created by 岩田彬広 on 2017/07/12.
//  Copyright © 2017年 com.Akihiro.Iwata. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {

    public func showIndicator(vc: UIViewController) {
        self.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.layer.cornerRadius = 9
        self.backgroundColor = UIColor(red: 0/2555, green: 0/255, blue: 0/255, alpha: 0.7)
        self.center = vc.view.center
        self.hidesWhenStopped = false
        self.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        self.startAnimating()
        vc.view.addSubview(self)
    }
    
    public func hideIndicator() {
        self.stopAnimating()
        self.removeFromSuperview()
    }

}
