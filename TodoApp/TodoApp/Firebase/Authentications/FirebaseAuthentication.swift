import FirebaseAuth
import Foundation
import GoogleSignIn

protocol FirebaseAuthentication: BaseViewController {
    var firebaseAuth: Auth { get set }
    var googleSignIn: GIDSignIn { get set }
}

// MARK: Firebase Email

extension FirebaseAuthentication {
    func loginWith(email: String, password: String, loginSuccesed: @escaping () -> Void) {
        displayIndicator(isShow: true)
        firebaseAuth.signIn(withEmail: email, password: password) { [weak self] _, error in
            DispatchQueue.main.async {
                self?.displayIndicator(isShow: false)
                if let error = error {
                    self?.showAlert(title: "Error", message: error.localizedDescription, actions: [.okAction()])
                } else {
                    loginSuccesed()
                }
            }
        }
    }
}

// MARK: Firebase Google

extension FirebaseAuthentication {
    func loginWithGoogle(loginSuccesed: @escaping () -> Void) {
        googleSignIn.signIn(withPresenting: self) { [weak self] result, error in
            guard error == nil else { return }
            guard let user = result?.user, let idToken = user.idToken?.tokenString else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            self?.loginWith(credential: credential, loginSuccesed: loginSuccesed)
        }
    }

    private func loginWith(credential: AuthCredential, loginSuccesed: @escaping () -> Void) {
        displayIndicator(isShow: true)
        firebaseAuth.signIn(with: credential) { [weak self] _, error in
            DispatchQueue.main.async {
                self?.displayIndicator(isShow: false)
                if let error = error {
                    self?.showAlert(title: "Error", message: error.localizedDescription, actions: [.okAction()])
                } else {
                    loginSuccesed()
                }
            }
        }
    }
}
