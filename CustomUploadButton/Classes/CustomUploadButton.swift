//
//  CustomUploadButton.swift
//  Pods
//
//  Created by Anand on 09/12/16.
//
//

import Foundation

public class CustomUploadButton : UIButton {
    
    let bgColor = UIColor(red: 96/255.0, green: 124/255.0, blue: 157/255.0, alpha: 1.0)
    
    public func setUpButton(title:String) {
        self.backgroundColor = bgColor
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitle(title, for: .normal)
    }
}
