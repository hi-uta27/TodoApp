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
    private lazy var photoManager = ImagePickerManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        photoManager.didFinishPicked = { [weak self] imageURL in
            do {
                let imageData = try Data(contentsOf: imageURL)
                self?.changeImage(imageData)
            } catch {
                self?.showAlert(title: "Error", message: error.localizedDescription, actions: [.okAction()])
            }
        }
    }

    private func changeImage(_ image: Data) {
        displayIndicator(isShow: true)
        changeImageUseCase.changeImage(image) { [weak self] result in
            DispatchQueue.main.async {
                self?.displayIndicator(isShow: false)
                switch result {
                case .success(let imageURL):
                    self?.changeAccountImageSuccess?(imageURL)
                    self?.dismiss(animated: true)
                case .failure(let error):
                    self?.showAlert(title: "Error", message: error.localizedDescription, actions: [.okAction()])
                }
            }
        }
    }

    @IBAction private func touchUpInsideTackPictureButton(_ sender: Any) {
        print(Self.self, #function)
        photoManager.openCamera(viewController: self)
    }

    @IBAction private func touchUpInsideImportFormGalleryButton(_ sender: Any) {
        print(Self.self, #function)
        photoManager.openPhotoLibrary(viewController: self)
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
