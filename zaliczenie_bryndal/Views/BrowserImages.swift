import SwiftUI
import PhotosUI

struct BrowserImages: View {
    @State private var image: UIImage?
    @State private var showingImagePicker = false
    @State private var isLoadingImage = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @StateObject private var viewModel = BrowserInagesViewModel()

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Select an image")
            }

            Button("Select Image") {
                self.showingImagePicker = true
            }
            
            Button(action: {
                if let image = self.image {
                    isLoadingImage.toggle()
                    Task {
                        await viewModel.sendImageToAPI(image)
                        await MainActor.run {
                            isLoadingImage.toggle()
                            showAlert = true
                            alertMessage = "Image uploaded successfully!"
                        }
                    }
                } else {
                    print("No image selected.")
                }
            }) {
                if isLoadingImage {
                    Text("Sending image...")
                } else {
                    Text("Send Image")
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Success"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $image)
        }
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
