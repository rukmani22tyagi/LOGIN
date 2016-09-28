//
//  ViewController.swift
//  LOGIN
//
//  Created by Rukmani on 09/08/16.
//  Copyright © 2016 Rukmani. All rights reserved.
//

//
//  ViewController.swift
//  Login
//
//  Created by Rajat on 01/08/16.
//  Copyright © 2016 Rajat. All rights reserved.
//

import UIKit
import Alamofire

import SwiftyJSON


class LoginViewController: UIViewController {
    //MARK: Properties
    var loginKey: String = " "
    let staticURL = "http://54.169.241.123/api/rest-auth/"
    
    //MARK: Outlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // MARK: UIController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //errorLabel.enabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    //MARK: Action
    @IBAction func login(sender: AnyObject) {
        //print("Login")
        getKey()
    }
    // MARK: prepareForSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let secondVC: LoginDataViewController = segue.destinationViewController as! LoginDataViewController
        secondVC.key = self.loginKey
        secondVC.staticURL = self.staticURL
    }
    
    //MARK: Function to get key
    
    func getKey(){
        let urlAddon = "v2/login/"
        let finalURL = staticURL + urlAddon
        let username = userNameTextField.text! as String
        let password = passwordTextField.text! as String
        let parameters = ["input_value": username, "password": password]
        //print("\(finalURL)")
        Alamofire.request(.POST, finalURL, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .Success(let json):
                print("Success with JSON: \(json)")
                
                //let response = JSON as! NSDictionary
                //self.loginKey = response.objectForKey("key")! as! String
                let key_json = JSON(json)
                //print(json)
                if let key = key_json["key"].string{
                    self.loginKey = key
                }
                
                self.performSegueWithIdentifier("sendKey", sender: nil)
                //print("\(self.loginKey)")
                
            case .Failure(let error):
                print("Request failed with error: \(error)")
                var errorMessage = "Username or Password field cannot be empty"
                
                if let data = response.data {
                    let responseJSON = JSON(data: data)
                    print(responseJSON)
                    if let message: String = responseJSON["error_desc"].stringValue {
                        if !message.isEmpty {
                            errorMessage = message
                            
                            //self.errorLabel.enabled = true
                            //self.errorLabel.text = errorMessage
                            //SCLAlertView().showError("Invalid Login", subTitle: errorMessage)
                        }
                    }
                }
                //self.errorLabel.enabled = true
                //self.errorLabel.text = errorMessage
              
               print(errorMessage) //Contains General error message or specific.
                return
            }
            
        }
        
        
    }
    
}