//
//  UserEntity+CoreDataProperties.swift
//  CoreDataLogin
//
//  Created by Rajeev on 12/07/23.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var imageName:String?

}

extension UserEntity : Identifiable {

}
