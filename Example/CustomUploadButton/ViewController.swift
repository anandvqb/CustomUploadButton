//
//  ViewController.swift
//  CustomUploadButton
//
//  Created by anandvqb on 12/09/2016.
//  Copyright (c) 2016 anandvqb. All rights reserved.
//

import UIKit
import CustomUploadButton

class ViewController: UIViewController {
    
    let buttonWidth:CGFloat = 300
    let buttonHeight:CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewFrame = view.frame
        
        let customUploadButton = CustomUploadButton(frame: CGRect(x:(viewFrame.width - buttonWidth)/2, y:(viewFrame.height - buttonHeight)/2, width:buttonWidth, height:buttonHeight))
        
        customUploadButton.setUpButton(title: "Custom Upload Button")
        
        view.addSubview(customUploadButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

