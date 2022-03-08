//
//  User.swift
//  Concurrency
//
//  Created by Eric Eaton on 3/8/22.
//

import Foundation

//https://jsonplaceholder.typicode.com/users

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
