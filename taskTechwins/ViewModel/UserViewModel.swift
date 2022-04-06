//
//  UserViewModel.swift
//  taskTechwins
//
//  Created by Akshay Sharma on 05/04/22.
//

import Foundation
import UIKit

class UserViewModel {
    
    //MARK:- Variables
    weak var vc: ViewController?
    
    func areAllFieldsValid() -> Bool {
        guard ((vc?.txtFirstName.text?.isEmpty) != nil) && vc?.txtFirstName.text != "" else {
            showAlert(title: "First Name", message: "First Name Can't Be Empty")
            return false
        }
        guard ((vc?.txtEmail.text?.isEmpty) != nil) && validate(email: vc?.txtEmail.text ?? "") && vc?.txtEmail.text != "" else {
            showAlert(title: "Email", message: "Please Enter Valid Email.")
            return false
        }
        guard ((vc?.txtUserName.text?.isEmpty) != nil) && vc?.txtUserName.text != "" else {
            showAlert(title: "User Name", message: "User Name Can't Be Empty")
            return false
        }
        guard ((vc?.txtPassword.text?.isEmpty) != nil) && vc?.txtPassword.text?.count ?? 0 > 8 && vc?.txtPassword.text != "" else {
            showAlert(title: "Password", message: "Password Length Should Be Grater Than 8")
            return false
        }
        
        return true
    }
    
    func validate(email: String) -> Bool {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: email)
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
     vc?.present(alert, animated: true, completion: nil)
    }
    
    func hitLoginApi(parameters:[String:String], completionHandler: @escaping (UserModel?, Bool) -> Swift.Void) {

        guard let gitUrl = URL(string: "http://dbt.teb.mybluehostin.me/housemate/public/api/signup") else { return }
        print(gitUrl)

        let request = NSMutableURLRequest(url: gitUrl)
      
        let session = URLSession.shared
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])

        let _ = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if error == nil {
                if let data = data {
                    do{
                        let userResponse = try JSONDecoder().decode(UserModel.self, from: data)
                        completionHandler(userResponse, true)
                    }catch let err {
                        completionHandler(nil,false)
                    }
                }
            } else {
                completionHandler(nil,false)
            }
        }.resume()
    }
    
}
