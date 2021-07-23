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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

//        progressBar.indicatorTextDisplayMode.
//        progressBar.indicatorTextLabel.textColor = UIColor.red
        progressBar.setTypeText(.fixedRight)
        progressBar.cornerRadius = CGFloat(10)
        progressBar.indicatorTextLabel.font = UIFont.systemFont(ofSize: 50)
        
    }

    @IBAction func testButton(_ sender: Any) {
        let progress = progressBar.progress + 0.1
        
        progressBar.setProgress(CGFloat(progress), animated: true)
        
    }
    
    @IBAction func menosButton(_ sender: Any) {
        let progress = progressBar.progress - 0.1
        
        progressBar.setProgress(CGFloat(progress), animated: true)
    }
}

