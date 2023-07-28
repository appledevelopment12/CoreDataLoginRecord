//
//  RegisterViewController.swift
//  CoreDataLogin
//
//  Created by Rajeev on 12/07/23.
//

import UIKit
import PhotosUI

class RegisterViewController: UIViewController {
    
    
    
    @IBOutlet weak var firstNamefield: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailFfield: UITextField!
    @IBOutlet weak var passordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    private let manager = DatabaseManager()
    private var imageSelectedBuUser:Bool = false
    var user:UserEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        
    }
}

extension RegisterViewController
{
    @IBAction func registerButtonTapped(_ sender: UIButton)
    {
        
        guard let firstName = firstNamefield.text,!firstName.isEmpty else{openAlert(message:"please enter your fistName")
            return
        }
        guard let lastName = lastNameField.text,!lastName.isEmpty else{openAlert(message:"please enter your lastName")
            return
        }
        guard let email = emailFfield.text,!email.isEmpty else{openAlert(message:"please enter your email ")
            return
        }
        guard let password = passordField.text,!password.isEmpty else{openAlert(message:"please enter your password")
            return
        }
        if !imageSelectedBuUser {
            openAlert(message: "Please choose your profile image.")
            return
        }
     
        if let user {
            
            //new user  = BHAI
            // USER (USER ENTITY) -STORE USER HAI - ROHIT
            //ROHIT = BHAI
            
           // let imageName = UUID().uuidString
            var newuser  = UserModel(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password,
                imageName: user.imageName ?? " "
            )
            saveImageToDocumentDiretoy(imageName:newuser.imageName)
            manager.updateUser(user: newuser, userEntity: user)
        }
        else
        {
            
            let imageName = UUID().uuidString
            var newuser  = UserModel(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password,
                imageName: imageName
            )
            saveImageToDocumentDiretoy(imageName: imageName)
            manager.addUser(newuser)
        }
             navigationController?.popViewController(animated: true)
    }
    

}

extension RegisterViewController
{
    func openAlert(message:String)
    {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "okay", style: .default)
        alertController.addAction(okay)
        present(alertController,animated: true)
    }
}


extension RegisterViewController:PHPickerViewControllerDelegate
{
    
    func configuration()
    {
        uiconfireuation()
        adddGesture()
        userDetailConfiguration()
        
    }
    
    func uiconfireuation()
    {
        navigationItem.title = "Add User "
        profileImage.layer.cornerRadius = profileImage.frame.size.height/2
    }
    func adddGesture()
    {
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.openGallery))
        profileImage.addGestureRecognizer(imageTap)
    }
 
     func  userDetailConfiguration()
    {
        if let user {
            registerButton.setTitle("Update", for: .normal)
            navigationItem.title = "Update user "
            firstNamefield.text = user.firstName
            lastNameField.text = user.lastName
            emailFfield.text = user.email
            passordField.text = user.password
            let imageURL  = URL.documentsDirectory.appending(component: user.imageName ?? "").appendingPathExtension("png")
            profileImage.image = UIImage(contentsOfFile: imageURL.path)
        imageSelectedBuUser = true
        }
        else
        {
            navigationItem.title = "Add user "
            registerButton.setTitle("Register", for: .normal)
        }
    }
    
    func saveImageToDocumentDiretoy(imageName:String)
    {
        let fileURL = URL.documentsDirectory.appending(components:imageName).appendingPathExtension("png")
        if let data = profileImage.image?.pngData()
        {
            do
            {
                try data.write(to: fileURL)
            }
            catch
            {
                print("saving image to document directory")
            }
        }
    }
    @objc func openGallery()
    {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
    
        let pickerVC = PHPickerViewController(configuration: config)
        pickerVC.delegate = self
        present(pickerVC,animated: true)
    }

    func picker(_ picker: PHPickerViewController,didFinishPicking results:[PHPickerResult]){
        dismiss(animated: true)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { image,error in
                guard let image = image as? UIImage else { return }
                DispatchQueue.main.async {
                    self.profileImage.image = image
                    self.imageSelectedBuUser = true
                }
            }
        }
    }
}
