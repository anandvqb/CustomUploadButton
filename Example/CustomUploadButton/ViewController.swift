//
//  ViewController.swift
//  CustomUploadButton
//
//  Created by anandvqb on 12/09/2016.
//  Copyright (c) 2016 anandvqb. All rights reserved.
//

import UIKit
import CustomUploadButton

class ViewController: UIViewController, CustomUploadButtonActionDelegate {
    
    @IBOutlet var uploadButton: CustomUploadButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadButton.delegate = self
        
        view.addSubview(uploadButton)
    }
    
    public func buttonAction(sender: CustomUploadButton) {
        //Do stuff on button action here
        
        if sender == uploadButton {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.uploadButton.stopAnimation()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
