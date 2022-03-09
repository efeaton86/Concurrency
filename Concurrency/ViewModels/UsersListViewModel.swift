//
//  UsersListViewModel.swift
//  Concurrency
//
//  Created by Eric Eaton on 3/8/22.
//

import Foundation

class UsersListViewModel: ObservableObject {
    @Published var usersAndPosts: [UserAndPosts] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    @MainActor
    func fetchUsers() async {
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        let apiService2 = APIService(urlString: "https://jsonplaceholder.typicode.com/posts")
        isLoading.toggle()
        defer {
            isLoading.toggle()
        }
        do {
            // fetch users and posts in parallel
            async let users: [User] = try await apiService.getJSON()
            async let posts: [Post] = try await apiService2.getJSON()
            let (fetchedUsers, fetchedPosts) = await (try users, try posts)
            
            for user in fetchedUsers {
                let userPosts = fetchedPosts.filter { $0.userId == user.id }
                let newUserAndPosts = UserAndPosts(user: user, posts: userPosts)
                usersAndPosts.append(newUserAndPosts)
            }
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription + "\nPlease contact the developer and provide this error and the steps to reproduce."
        }
        
        
        
        
        
//        this simiulates slow connection
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {}
//        apiService.getJSON { (result: Result<[User], APIError>) in
//            // defer will run after json is loaded and decoded
//            defer {
//                DispatchQueue.main.async {
//                    self.isLoading.toggle()
//                }
//            }
//            switch result {
//            case .success(let users):
//                DispatchQueue.main.async {
//                    self.users = users
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self.showAlert = true
//                    self.errorMessage = error.localizedDescription + "\nPlease contact the developer and provide this error and the steps to reproduce."
//                }
//            }
//        }
        
        

    }
}

extension UsersListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.usersAndPosts = UserAndPosts.mockUsersAndPosts
        }
    }
}
