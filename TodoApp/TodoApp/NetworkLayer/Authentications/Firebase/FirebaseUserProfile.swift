//
//  FirebaseUserProfile.swift
//  TodoApp
//
//  Created by TaHieu on 7/16/23.
//

import FirebaseAuth
import Foundation

enum FirebaseUserProfileError: LocalizedError {
    case changeAccountNameFailure

    var errorDescription: String? {
        switch self {
        case .changeAccountNameFailure:
            return "Change account name failure"
        }
    }
}

class FirebaseUserProfile {
    private let firebaseAuth: Auth

    init(firebaseAuth: Auth = .auth()) {
        self.firebaseAuth = firebaseAuth
    }
}

extension FirebaseUserProfile {
    func readUserInfo(completed: @escaping (UserDTO?) -> Void) {
        completed(firebaseAuth.currentUser)
    }

    func changeAccountName(_ name: String, completed: @escaping (Result<String, Error>) -> Void) {
        let changeRequest = firebaseAuth.currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges { error in
            if let error = error {
                completed(.failure(error))
            } else {
                completed(.success(name))
            }
        }
    }

    func changePassword(_ password: String, oldPassword: String, completed: @escaping (Error?) -> Void) {
        guard let email = firebaseAuth.currentUser?.email else { return }
        firebaseAuth.signIn(withEmail: email, password: oldPassword) { auth, error in
            if let error = error {
                completed(error)
            } else {
                auth?.user.updatePassword(to: password, completion: completed)
            }
        }
    }
}
