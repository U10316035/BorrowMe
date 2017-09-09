//
//  FinishUploadViewController.swift
//  BorrowME
//
//  Created by UTaipei on 2017/9/8.
//  Copyright © 2017年 team3. All rights reserved.
//

import UIKit

class FinishUploadViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        //set view
        backButton.layer.cornerRadius = 15
        //set view end
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backToMainPage(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
        
    }
    
}
