//
//  User.swift
//  To Do
//
//  Created by Максим Лебедев on 07.09.2021.
//

import Foundation
import Firebase

struct Users {
    
    let uid: String
    let email: String
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email!
    }
    
}
