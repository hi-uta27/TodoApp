//
//  ChangeAccountImageViewController.swift
//  TodoApp
//
//  Created by TaHieu on 7/16/23.
//

import UIKit

class ChangeAccountImageViewController: BaseViewController {
    private var changeAccountImageSuccess: ((URL) -> Void)!

    private lazy var changeImageUseCase = di.resolve(ChangeAccountImageUseCase.self)!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func touchUpInsideTackPictureButton(_ sender: Any) {
        print(Self.self, #function)
    }

    @IBAction private func touchUpInsideImportFormGalleryButton(_ sender: Any) {
        print(Self.self, #function)
    }

    @IBAction private func touchUpInsideImportFormGoogleDriveButton(_ sender: Any) {
        print(Self.self, #function)
    }
}

extension ChangeAccountImageViewController {
    static func initial(changeAccountImageSuccess: @escaping (URL) -> Void) -> Self {
        let viewController = initial()
        viewController.changeAccountImageSuccess = changeAccountImageSuccess
        return viewController
    }
}

extension UIViewController {
    func presentChangeAccountImage(changeAccountImageSuccess: @escaping (URL) -> Void, complete: (() -> Void)?) {
        let viewController = ChangeAccountImageViewController.initial(changeAccountImageSuccess: changeAccountImageSuccess)
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true, completion: complete)
    }
}
