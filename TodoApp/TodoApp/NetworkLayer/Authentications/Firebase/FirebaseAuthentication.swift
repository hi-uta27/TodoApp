import FirebaseAuth
import GoogleSignIn
import UIKit

class FirebaseAuthentications {
    private let firebaseAuth: Auth
    private let googleSignIn: GIDSignIn
    private var viewController: UIViewController

    init(firebaseAuth: Auth = .auth(), googleSignIn: GIDSignIn = .sharedInstance, viewController: UIViewController = .init()) {
        self.firebaseAuth = firebaseAuth
        self.googleSignIn = googleSignIn
        self.viewController = viewController
    }
}

extension FirebaseAuthentications {
    func loginWith(email: String, password: String, completed: @escaping (Result<UserDTO, Error>) -> Void) {
        firebaseAuth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completed(.failure(error))
            } else {
                guard let userDTO = result?.user else { return }
                completed(.success(userDTO))
            }
        }
    }

    func loginWithGoogle(completed: @escaping (Result<UserDTO, Error>) -> Void) {
        googleSignIn.signIn(withPresenting: viewController) { [weak self] result, error in
            guard error == nil else { return }
            guard let user = result?.user, let idToken = user.idToken?.tokenString else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            self?.loginWith(credential: credential, completed: completed)
        }
    }

    private func loginWith(credential: AuthCredential, completed: @escaping (Result<UserDTO, Error>) -> Void) {
        firebaseAuth.signIn(with: credential) { result, error in
            if let error = error {
                completed(.failure(error))
            } else {
                guard let userDTO = result?.user else { return }
                completed(.success(userDTO))
            }
        }
    }

    func registerWith(email: String, password: String, completed: @escaping (Result<UserDTO, Error>) -> Void) {
        firebaseAuth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completed(.failure(error))
            } else {
                guard let userDTO = result?.user else { return }
                completed(.success(userDTO))
            }
        }
    }

    func readUserInfo(completed: @escaping (UserDTO?) -> Void) {
        completed(firebaseAuth.currentUser)
    }

    func logout(completed: @escaping (Error?) -> Void) {
        do {
            try firebaseAuth.signOut()
            completed(nil)
        } catch {
            completed(error)
        }
    }
}
