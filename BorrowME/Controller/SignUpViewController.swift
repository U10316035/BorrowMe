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
    override func viewDidLoad() {
        super.viewDidLoad()

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
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "signupPage")
                    self.present(vc!, animated: true, completion: nil)
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

}
