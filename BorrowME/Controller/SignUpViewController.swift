//
//  SignUpViewController.swift
//  BorrowME
//
//  Created by UTaipei on 2017/9/7.
//  Copyright © 2017年 team3. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var studentIdField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    
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
    
    /*@IBAction func dismissNext(segue: UIStoryboardSegue){
        dismiss(animated: false, completion: nil)
    }*/
    
    @IBAction func cancelButtonAct(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func joinButtonAct(_ sender: Any) {
        if emailField.text == "" {
            let alertController = UIAlertController(title: "Error",
                                                    message: "Please enter your email and password",
                preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: emailField.text!,
                                   password: passwordField.text!)
            { (user, error) in
                if error == nil {
                    print("You have successfully signed up")
                    /*let vc = self.storyboard?.instantiateViewController(withIdentifier: "signupPage")
                    self.present(vc!, animated: true, completion: nil)*/
                    
                    //create new user data to database
                    self.uploadNewUserData()
                    
                    //close sign up view
                    self.dismiss(animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Error",
                                                            message: error?.localizedDescription,
                                                            preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func setViewFunc(){
        nameField.layer.borderWidth = 2
        nameField.layer.borderColor = UIColor.white.cgColor
        nameField.layer.cornerRadius = 8
        nameField.attributedPlaceholder = NSAttributedString(string:"  Your Name", attributes:[NSAttributedStringKey.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)])
        nameField.layer.masksToBounds = true
        
        emailField.layer.borderWidth = 2
        emailField.layer.borderColor = UIColor.white.cgColor
        emailField.layer.cornerRadius = 8
        emailField.attributedPlaceholder = NSAttributedString(string:"  School Email", attributes:[NSAttributedStringKey.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)])
        emailField.layer.masksToBounds = true
        
        passwordField.layer.borderWidth = 2
        passwordField.layer.borderColor = UIColor.white.cgColor
        passwordField.layer.cornerRadius = 8
        passwordField.attributedPlaceholder = NSAttributedString(string:"  Password", attributes:[NSAttributedStringKey.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)])
        passwordField.layer.masksToBounds = true
        
        genderField.layer.borderWidth = 2
        genderField.layer.borderColor = UIColor.white.cgColor
        genderField.layer.cornerRadius = 8
        genderField.attributedPlaceholder = NSAttributedString(string:"  Gender", attributes:[NSAttributedStringKey.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)])
        genderField.layer.masksToBounds = true
        
        studentIdField.layer.borderWidth = 2
        studentIdField.layer.borderColor = UIColor.white.cgColor
        studentIdField.layer.cornerRadius = 8
        studentIdField.attributedPlaceholder = NSAttributedString(string:"  Student ID No.", attributes:[NSAttributedStringKey.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)])
        studentIdField.layer.masksToBounds = true
        
        loginButton.layer.cornerRadius = 15
        joinButton.layer.cornerRadius = 15
    }
    
    func uploadNewUserData(){
        uploadData["name"] = nameField.text
        uploadData["mail"] = emailField.text
        uploadData["password"] = passwordField.text
        uploadData["studentId"] = studentIdField.text
        uploadData["gender"] = genderField.text
        
        generateUserIdIfNotExist()
    }
    
    func generateUserIdIfNotExist(){
        var idGenerate:Int = 0
        idGenerate = Int(arc4random_uniform(100000001))
        //print(idGenerate)
        ref.child("user").child("user\(idGenerate)").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() == true {
                
                //call itself if id exist
                self.generateUserIdIfNotExist()
            }
            else {
                self.uploadData["id"] = "\(idGenerate)"
                
                //send data to firebase
                self.ref.child("user").child("user\(idGenerate)").setValue(self.uploadData)
            }

        }){ (error) in
            print(error.localizedDescription)
        }
    }
}
