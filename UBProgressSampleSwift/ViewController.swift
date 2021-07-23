//
//  ViewController.swift
//  UBProgressSampleSwift
//
//  Created by Paulo Uchôa on 21/07/21.
//

import UIKit
import UBProgress

class ViewController: UIViewController {

    @IBOutlet weak var progressBar: UBProgress!
    
    @IBOutlet weak var progressBar2: UBProgress!
    
    @IBOutlet weak var progressBar3: UBProgress!
    
    @IBOutlet weak var progressBar4: UBProgress!
    
    @IBOutlet weak var progressBar5: UBProgress!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressBar.setTypeText(.fixedCenter)
        progressBar.setFont(UIFont.systemFont(ofSize: 20))
        
        progressBar2.setTypeText(.fixedRight)
        progressBar2.setFont(UIFont(name: "Chalkduster", size: 20) ?? UIFont.systemFont(ofSize: 30))
        
        progressBar3.setTypeText(.progressCenter)
        progressBar3.setFont(UIFont(name: "Courier New", size: 20) ?? UIFont.systemFont(ofSize: 30))
        
        progressBar4.setTypeText(.progressRight)
        progressBar4.setFont(UIFont(name: "Arial", size: 20) ?? UIFont.systemFont(ofSize: 30))
        
        progressBar5.setTypeText(.none)
    }
    
    @IBAction func steperButton(_ sender: UIStepper) {
        
        let progress = sender.value/100
        
        print(sender.value)
        progressBar.setProgress(CGFloat(progress), animated: true)
        progressBar2.setProgress(CGFloat(progress), animated: true)
        progressBar3.setProgress(CGFloat(progress), animated: true)
        progressBar4.setProgress(CGFloat(progress), animated: true)
        progressBar5.setProgress(CGFloat(progress), animated: true)
        
    }
}

