import SwiftUI
import PhotosUI

struct RecognizerView: View {
    
    @StateObject private var recognizer = Recognizer()
    @State var selectedImage: PhotosPickerItem? = nil
    @State private var createImage: UIImage?
    @State private var shouldNavigate = false
    @State private var showCamera = false
    
    var body: some View {
        NavigationView {
            VStack {
                if shouldNavigate, let image = recognizer.image {
                    NavigationLink(destination: RecognitionResult(recognizer: recognizer, image: image), isActive: $shouldNavigate) {
                        EmptyView()
                    }
                    .hidden()
                } else {
                    VStack {
                        WarningView()
                        
                        Button("Camera") {
                            self.showCamera.toggle()
                        } .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("Accent"))
                            .cornerRadius(10)
                            .fullScreenCover(isPresented: self.$showCamera) {
                                accessCameraView(createImage: self.$createImage)
                            }.onChange(of: createImage){
                                
                                recognizer.image =  createImage
                                recognizer.classifier()
                                recognizer.multiClassifier()
                                shouldNavigate = true
                                
                            }
                        PhotosPicker(
                            selection: $selectedImage,
                            matching: .images,
                            photoLibrary: .shared()
                        ) {
                            Text("Photo Library")
                                .fontWeight(.bold)
                                .foregroundColor(Color("Accent"))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("Accent"), lineWidth: 2)
                                )
                        }.onChange(of: selectedImage) { newItem in
                            Task {
                                if let imageData = try? await newItem?.loadTransferable(type: Data.self) {
                                    recognizer.image = UIImage(data: imageData)
                                    recognizer.classifier()
                                    recognizer.multiClassifier()
                                    shouldNavigate = true
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Pizza Recognizer")
            .padding()
        }
    }
}


struct accessCameraView: UIViewControllerRepresentable {
    @Binding var createImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    
    init(picker: accessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.createImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}

#Preview {
    RecognizerView()
}
