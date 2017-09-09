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
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                    self.performSegue(withIdentifier: "loginToMainPageSegue", sender: nil)
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
    
    //send value to mainPage
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mainVC:MainPageViewController = segue.destination as! MainPageViewController
        mainVC.userData = "DataSend"
    }

}
