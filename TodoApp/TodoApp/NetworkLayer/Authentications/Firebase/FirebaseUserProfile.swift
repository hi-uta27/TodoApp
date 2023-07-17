//
//  FirebaseUserProfile.swift
//  TodoApp
//
//  Created by TaHieu on 7/16/23.
//

import FirebaseAuth
import FirebaseStorage
import Foundation

class FirebaseUserProfile {
    private let firebaseAuth: Auth
    private let firebaseStorage: Storage

    init(firebaseAuth: Auth = .auth(), firebaseStorage: Storage = .storage()) {
        self.firebaseAuth = firebaseAuth
        self.firebaseStorage = firebaseStorage
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

    func changeImage(_ image: Data, completed: @escaping (Result<URL, Error>) -> Void) {
        guard let user = firebaseAuth.currentUser else { return }
        let storageReference = firebaseStorage.reference().child("UserProfileImages/\(user.uid)")
        storageReference.putData(image) { [weak self] result in
            switch result {
            case .success:
                self?.downloadPhotoUrl(user: user, storageReference: storageReference, completed: completed)
            case .failure(let failure):
                completed(.failure(failure))
            }
        }
    }

    private func downloadPhotoUrl(user: User, storageReference: StorageReference, completed: @escaping (Result<URL, Error>) -> Void) {
        storageReference.downloadURL { [weak self] url, error in
            if let error = error {
                completed(.failure(error))
            } else {
                guard let url = url else { return }
                self?.setPhotoUrl(url, for: user, completed: completed)
            }
        }
    }

    private func setPhotoUrl(_ url: URL, for user: User, completed: @escaping (Result<URL, Error>) -> Void) {
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.photoURL = url
        changeRequest.commitChanges { error in
            if let error = error {
                completed(.failure(error))
            } else {
                completed(.success(url))
            }
        }
    }
}
