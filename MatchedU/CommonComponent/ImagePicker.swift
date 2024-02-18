
import SwiftUI

/// Image Picker Representable
///
///

struct ProfileImagePicker: UIViewControllerRepresentable {

typealias imagePickerController = UIImagePickerController

@Binding var image: UIImage?
@Binding var isShown: Bool
@Binding var isProfileCropView: Bool

var photo_for = Photo_Select_for.cover
    
var sourceType: UIImagePickerController.SourceType = .camera

func makeUIViewController(context: Context) -> some UIViewController {
let imagePicker = UIImagePickerController()
imagePicker.sourceType = sourceType
imagePicker.delegate = context.coordinator
return imagePicker
}

func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

}

func makeCoordinator() -> Coordinator {
    return Coordinator(image: $image, isShown: $isShown , isProfileCropView : $isProfileCropView , photo_for : photo_for)
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

@Binding var image: UIImage?
@Binding var isShown: Bool
@Binding var isProfileCropView: Bool
var photo_for = Photo_Select_for.cover
    
var sourceType: UIImagePickerController.SourceType = .camera

    init(image: Binding<UIImage?    >, isShown: Binding<Bool> , isProfileCropView : Binding<Bool> , photo_for : Photo_Select_for ) {
        _image = image
        _isShown = isShown
        _isProfileCropView = isProfileCropView
        
}
    
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
    image = uiImage
    isShown = false
   }
}

func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
isShown = false
}
}
}

