//
//  ResetPasswordViewController.swift
//  BorrowME
//
//  Created by UTaipei on 2017/9/7.
//  Copyright © 2017年 team3. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

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
    @IBAction func sendButtonAct(_ sender: Any) {
        if self.emailField.text == "" {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().sendPasswordReset(withEmail: self.emailField.text!, completion: { (error) in
                var title = ""
                var message = ""
                if error != nil {
                    title = "Error!"
                    message = (error?.localizedDescription)!
                } else {
                    title = "Success!"
                    message = "Password reset email sent."
                    self.emailField.text = ""
                }
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            })
        }

    }
    
    @IBAction func loginButtonAct(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
