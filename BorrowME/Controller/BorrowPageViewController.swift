//
//  BorrowPageViewController.swift
//  BorrowME
//
//  Created by UTaipei on 2017/9/8.
//  Copyright © 2017年 team3. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class BorrowPageViewController: UIViewController {
    @IBOutlet weak var itemField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    
    //use for test id
    var userId:String = "00000000"
    
    //database connection
    var ref: DatabaseReference!
    
    //data to upload
    var uploadData:[String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirm(_ sender: Any) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let result = formatter.string(from: date)
        
        let dataTitle:String = result + userId
        print(dataTitle)
        
        //set upload data
        uploadData["description"] = descriptionField.text
        uploadData["item"] = itemField.text
        uploadData["location"] = locationField.text
        uploadData["timeLimit"] = timeField.text
        uploadData["userId"] = userId
        
        //send data to firebase
        self.ref.child("borrowList").child("data\(dataTitle)").setValue(uploadData)
        
        performSegue(withIdentifier: "toFinishUploadPage", sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func xButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func home(segue:UIStoryboardSegue){
        //dismiss(animated: false, completion: nil)
    }
    
}
