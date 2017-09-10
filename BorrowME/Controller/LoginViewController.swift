//
//  LoginViewController.swift
//  BorrowME
//
//  Created by UTaipei on 2017/9/7.
//  Copyright © 2017年 team3. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    var ref: DatabaseReference!
    
    var downloadData:[String:Any] = [:]
    
    //var whichSegue = 2
    
    var sendUserData:[String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //reference to firebase
        ref = Database.database().reference()
        
        //set view style
        userNameLabel.layer.borderWidth = 2
        userNameLabel.layer.borderColor = UIColor.white.cgColor
        userNameLabel.layer.cornerRadius = 8
        //userNameLabel.layer.masksToBounds = true
        
        passwordLabel.layer.borderWidth = 2
        passwordLabel.layer.borderColor = UIColor.white.cgColor
        passwordLabel.layer.cornerRadius = 8
        //passwordLabel.layer.masksToBounds = true
        
        loginButton.layer.cornerRadius = 15
        
        usernameField.attributedPlaceholder = NSAttributedString(string:"E-Mail", attributes:[NSAttributedStringKey.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)])
        //usernameField.layer.borderWidth = 0
        passwordField.attributedPlaceholder = NSAttributedString(string:"Password", attributes:[NSAttributedStringKey.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)])
        //passwordField.layer.borderWidth = 0
        
        //end set view style
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonAct(_ sender: Any) {
        if self.usernameField.text == "" || self.passwordField.text == "" {
            let alertController = UIAlertController(title: "Error",
                                                    message: "Please enter an email and password.",
                                                    preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().signIn(withEmail: self.usernameField.text!,
                               password: self.passwordField.text!)
            { (user, error) in
                if error == nil {
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainPage")
//                    self.present(vc!, animated: true, completion: nil)
                    //self.whichSegue = 0
                    
                    //call prepare data to next view
                    self.prepareToGoMainPage()
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
    
    @IBAction func signUpButtonAct(_ sender: Any) {
        //whichSegue = 1
        performSegue(withIdentifier: "signUpSegue", sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func prepareToGoMainPage(){
        ref.child("user").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let data = snapshot.value as? NSDictionary{
                self.downloadData = data as! [String : Any]
            }
            
            for data in self.downloadData{
                if let dict = data.value as? [String: Any]{
                    if let mail = dict["mail"] as? String{
                        if mail == self.usernameField.text!{
                            self.sendUserData = dict
                            self.performSegue(withIdentifier: "loginToMainPageSegue", sender: nil)
                        }
                    }
                }
            }
            
        }){ (error) in
            print(error.localizedDescription)
        }
    }
    
    //send value to mainPage
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToMainPageSegue"{
            let mainVC:MainPageViewController = segue.destination as! MainPageViewController

            mainVC.userData = sendUserData
            //print(sendUserData)
            //mainVC.userData = "DataSend"
        }
    }

}
