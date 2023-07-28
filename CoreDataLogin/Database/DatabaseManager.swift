//
//  DatabaseManager.swift
//  CoreDataLogin
//
//  Created by Rajeev on 12/07/23.
//

import Foundation
import UIKit
import CoreData



class DatabaseManager
{
    private var context:NSManagedObjectContext
    {
        return(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func  addUser(_ user: UserModel)
    {
        let userEntity = UserEntity(context: context)  // User creater  karte the
        addUpdateUser(userEntity: userEntity, user: user)
        
    }
    func updateUser(user:UserModel,userEntity:UserEntity)
    {
        addUpdateUser(userEntity: userEntity, user: user)
    }
 private   func addUpdateUser(userEntity: UserEntity,user:UserModel)
    {
        userEntity.firstName = user.firstName
        userEntity.lastName = user.lastName
        userEntity.email = user.email
        userEntity.password = user.password
        userEntity.imageName = user.imageName
        saveContext()
    }

    
    func fetchUsers() -> [UserEntity]
    {
        var users:[UserEntity] = []
        do {
            users = try context.fetch(UserEntity.fetchRequest())
        }
        catch
        {
            print("fetc user error ",error)
        }
        return users
    }
    func saveContext()
    {
        do {
            try context.save()
        }
        catch {
            print("user saving error",error)
        }
    }
    
    func deleteUser(userEntity:UserEntity)
    {
        let imageURL = URL.documentsDirectory.appending(component: userEntity.imageName ?? "").appendingPathExtension("png")
        
        do {
            try  FileManager.default.removeItem(at: imageURL)
        }
        catch
        {
            print("remove image from DD",error)
        }
        context.delete(userEntity)
        saveContext()
    }
}
