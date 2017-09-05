//
//  TestViewController.swift
//  BorrowME
//
//  Created by UTaipei on 2017/9/5.
//  Copyright © 2017年 team3. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class TestViewController: UIViewController {
    @IBOutlet weak var textF: UITextField!
    
    @IBOutlet weak var label: UILabel!
    lazy var ref = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref.observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            self.label.text = postDict["name"] as? String
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttAct(_ sender: Any) {
        self.ref.setValue(["name": textF.text])
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
