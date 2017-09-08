//
//  ViewController.swift
//  BorrowME
//
//  Created by user on 2017/9/3.
//  Copyright © 2017年 team3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        let myColor = UIColor(red: 0.196, green: 0.149, blue: 0.416, alpha: 1)
        self.view.backgroundColor = myColor
        // Do any additional setup after loading the view, typically from a nib.
        timer = Timer.scheduledTimer(timeInterval: 3,
                                      target: self,
                                      selector: #selector(self.showNextAndStopTimer),
                                      userInfo: nil,
                                      repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func showNextAndStopTimer(){
        performSegue(withIdentifier: "loginPage", sender: nil)
        timer.invalidate()
    }

}

