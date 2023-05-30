//
//  ImagePicker.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 24/04/2023.
//

import Foundation
import SwiftUI

/* ViewController that will enable us to show the user's photo library
 or their camera feed. To change between these two options, we have a var
 sourceType. The selectedImage var lets us preview the selected image in the view
 */

struct CameraView: UIViewControllerRepresentable {
	@Environment(\.presentationMode) private var presentationMode
	var sourceType: UIImagePickerController.SourceType = .photoLibrary
	@Binding var selectedImage: UIImage

	func makeUIViewController(context: UIViewControllerRepresentableContext<CameraView>) -> UIImagePickerController {

		let imagePicker = UIImagePickerController()
		imagePicker.allowsEditing = false
		imagePicker.sourceType = sourceType
		imagePicker.delegate = context.coordinator
		
		return imagePicker
	}

	func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CameraView>) {

	}

	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}

	final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

		var parent: CameraView

		init(_ parent: CameraView) {
			self.parent = parent
		}

		func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

			if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
				parent.selectedImage = image
			}
			parent.presentationMode.wrappedValue.dismiss()
		}
	}
}
