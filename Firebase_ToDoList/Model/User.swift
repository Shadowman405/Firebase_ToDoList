//
//  User.swift
//  Firebase_ToDoList
//
//  Created by Maxim Mitin on 15.12.21.
//

import Foundation
import Firebase

struct UserApp {
    let uid: String
    let email: String
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email!
    }
}
