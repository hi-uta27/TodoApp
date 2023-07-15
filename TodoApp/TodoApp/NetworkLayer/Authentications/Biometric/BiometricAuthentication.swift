import Foundation
import LocalAuthentication

protocol BiometricAuthentication: BaseViewController {}

extension BiometricAuthentication {
    private var context: LAContext {
        .init()
    }

    func loginWithBiometric(policy: LAPolicy = .deviceOwnerAuthentication, reason: String = "Login with Apple", loginSuccessed: @escaping () -> Void) {
        if canAuthenByBioMetrics() {
            context.evaluatePolicy(policy, localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    switch success {
                    case true:
                        loginSuccessed()
                    case false:
                        guard let error = error as? LAError, error.code != .userCancel else { return }
                        self?.showAlert(title: "Error", message: error.localizedDescription, actions: [.okAction()])
                    }
                }
            }
        } else {
            showAlert(title: "Error", message: "Biometry unavailable", actions: [.okAction()])
        }
    }

    private func canAuthenByBioMetrics() -> Bool {
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: .none) {
            return true
        } else {
            return false
        }
    }
}
