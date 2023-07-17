import UIKit

class ImagePickerManager: NSObject {
    var didFinishPicked: ((URL) -> Void)?

    func openCamera(viewController: UIViewController) {
        openImagePicker(from: viewController, sourceType: .camera)
    }

    func openPhotoLibrary(viewController: UIViewController) {
        openImagePicker(from: viewController, sourceType: .photoLibrary)
    }

    private func openImagePicker(from viewController: UIViewController, sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = sourceType
        viewController.present(pickerController, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension ImagePickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
        didFinishPicked?(imageURL)
        picker.dismiss(animated: true)
    }
}
