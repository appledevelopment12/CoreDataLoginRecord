//
//  UserCell.swift
//  CoreDataLogin
//
//  Created by Rajeev on 19/07/23.
//

import UIKit

class UserCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var emaillabel: UILabel!
    
    var user:UserEntity?
    {
        didSet
        {
            userConfiguration()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func userConfiguration()
    {
        guard let user else { return }
        fullNameLbl.text = (user.firstName ?? "" ) + " " + (user.lastName ?? " ")
        emaillabel.text = "Email: \(user.email ?? "" )"
        let imageURL = URL.documentsDirectory.appending(component: user.imageName ?? "" ) .appendingPathExtension("png")
        profileImageView.image = UIImage(contentsOfFile: imageURL.path)
    }
    
}
