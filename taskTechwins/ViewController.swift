//
//  ViewController.swift
//  taskTechwins
//
//  Created by Akshay Sharma on 05/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnCreateAccount: UIButton!
    
    var viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }

    func setUI() {
        let txtArr = [txtFirstName,txtEmail,txtUserName,txtPassword]
        for txtField in txtArr {
            txtField?.layer.cornerRadius = 20
            txtField?.setLeftPaddingPoints(20)
        }
        btnCreateAccount.layer.cornerRadius = btnCreateAccount.frame.height / 2
    }
    
    //MARK:- Button Action
    @IBAction func btnClickableCreatAccoubt(_ sender: UIButton) {
        viewModel.vc = self
        if viewModel.areAllFieldsValid() {
        let param = [
            "username": txtUserName.text ?? "",
            "name": txtFirstName.text ?? "",
            "email": txtEmail.text ?? "",
            "password": txtPassword.text ?? "",
            "device_token": "token",
            "device_type": "1"
          ]
        viewModel.hitLoginApi(parameters: param, completionHandler: { [weak self] userData,status in
            if status {
                DispatchQueue.main.async {
                    self?.viewModel.showAlert(title: "Success", message: userData?.message ?? "Login Successfully")
                }
            }
        })
    }
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
