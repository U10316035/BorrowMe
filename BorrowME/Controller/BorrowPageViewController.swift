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
    var userId:String = "00000001"
    
    //database connection
    var ref: DatabaseReference!
    
    //data to upload
    var uploadData:[String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //database reference
        ref = Database.database().reference()
        
        //set view
            setViewFunc()
        //end set view


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
        //print(dataTitle)
        
        //set upload data
        uploadData["description"] = descriptionField.text
        uploadData["item"] = itemField.text
        uploadData["location"] = locationField.text
        uploadData["timeLimit"] = timeField.text
        uploadData["userId"] = userId
        uploadData["uploadTime"] = result
        
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
    
    func setViewFunc(){
        
        //common value
        let width = CGFloat(2.0)
        let myColor = UIColor(red: 0.09, green: 0.165, blue: 0.533, alpha: 1)
        
        //itemField
        let borderItemField = CALayer()
        borderItemField.borderColor = myColor.cgColor
        borderItemField.frame = CGRect(x: 0, y: itemField.frame.size.height - width, width:  itemField.frame.size.width, height: itemField.frame.size.height)
        borderItemField.borderWidth = width
        itemField.layer.addSublayer(borderItemField)
        itemField.layer.masksToBounds = true
        itemField.attributedPlaceholder = NSAttributedString(string:"Item", attributes:[NSAttributedStringKey.foregroundColor: UIColor(red: 0.09, green: 0.165, blue: 0.533, alpha: 1)])
        
        //locationField
        let borderLocationField = CALayer()
        borderLocationField.borderColor = myColor.cgColor
        borderLocationField.frame = CGRect(x: 0, y: locationField.frame.size.height - width, width:  locationField.frame.size.width, height: locationField.frame.size.height)
        borderLocationField.borderWidth = width
        locationField.layer.addSublayer(borderLocationField)
        locationField.layer.masksToBounds = true
        locationField.attributedPlaceholder = NSAttributedString(string:"Location", attributes:[NSAttributedStringKey.foregroundColor: UIColor(red: 0.09, green: 0.165, blue: 0.533, alpha: 1)])
        
        //timeField
        let borderTimeField = CALayer()
        borderTimeField.borderColor = myColor.cgColor
        borderTimeField.frame = CGRect(x: 0, y: timeField.frame.size.height - width, width:  timeField.frame.size.width, height: timeField.frame.size.height)
        borderTimeField.borderWidth = width
        timeField.layer.addSublayer(borderTimeField)
        timeField.layer.masksToBounds = true
        timeField.attributedPlaceholder = NSAttributedString(string:"Due Time", attributes:[NSAttributedStringKey.foregroundColor: UIColor(red: 0.09, green: 0.165, blue: 0.533, alpha: 1)])
        
    }
}
