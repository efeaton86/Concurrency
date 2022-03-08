//
//  Post.swift
//  Concurrency
//
//  Created by Eric Eaton on 3/8/22.
//

// Source: https://jsonplaceholder.typicode.com/posts
// single user post: https://jsonplaceholder.typicode.com/users/1/posts

import Foundation

struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

