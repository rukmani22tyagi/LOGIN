//
//  LoginDataViewController.swift
//  LOGIN
//
//  Created by Rukmani on 09/08/16.
//  Copyright © 2016 Rukmani. All rights reserved.
//

import UIKit
import Alamofire

class LoginDataViewController: UIViewController {
    // MARK: Properties
    var key: String = ""
    var staticURL : String = ""
    
    // MARK: Outlets
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var birthdayLabel: UILabel!
    
    // MARK: UIController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        getUserData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Function to get User Data
    func getUserData(){
        let dataURLAddon = "user/"
        let finalDataURL = staticURL + dataURLAddon
        let finalKey = "Token" + " " + key
        let headers = ["Authorization": finalKey]
        
        
        Alamofire.request(.GET, finalDataURL, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .Success(let JSON):
                //print("Success with JSON: \(JSON)")
                let response = JSON as! NSDictionary
                let id = response.objectForKey("id") as! Int
                let email = response.objectForKey("email")! as! String
                let username = response.objectForKey("username")! as! String
                let phone = response.objectForKey("phone")! as! String
                let birthday = response.objectForKey("birthday")! as! String
                //print("id:\(id) email:\(email) username:\(username) phone:\(phone) birthday:\(birthday)")
                self.idLabel.text = String(id)
                self.emailLabel.text = email
                self.usernameLabel.text = username
                self.phoneLabel.text = phone
                self.birthdayLabel.text = birthday
                //print("\(self.loginKey)")
                
            case .Failure(let error):
                print("Request failed with error: \(error)")
                return
            }
            
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
