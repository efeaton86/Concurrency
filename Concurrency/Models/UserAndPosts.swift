//
//  UserAndPosts.swift
//  Concurrency
//
//  Created by Eric Eaton on 3/9/22.
//

import Foundation

struct UserAndPosts: Identifiable {
    var id = UUID()
    let user: User
    let posts: [Post]
    var numberOfPosts: Int {
        posts.count
    }
}
