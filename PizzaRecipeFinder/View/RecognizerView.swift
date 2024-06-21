import SwiftUI
import PhotosUI

struct RecognizerView: View {
    
    @StateObject private var recognizer = Recognizer()
    @State var selectedImage: PhotosPickerItem? = nil
    @State private var shouldNavigate = false
    
    var body: some View {
        NavigationView {
            VStack {
                if shouldNavigate, let data = recognizer.data, let image = UIImage(data: data) {
                    NavigationLink(destination: RecognitionResult(recognizer: recognizer, image: image), isActive: $shouldNavigate) {
                        EmptyView()
                    }
                    .hidden()
                } else {
                    VStack {
                        WarningView()
                        
                        Spacer()
                        
                        PhotosPicker(
                            selection: $selectedImage,
                            matching: .images,
                            photoLibrary: .shared()
                        ) {
                            Text("Recognize")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: 300)
                                .background(Color("Accent"))
                                .cornerRadius(10)
                        }.onChange(of: selectedImage) { newItem in
                            Task {
                                if let imageData = try? await newItem?.loadTransferable(type: Data.self) {
                                    recognizer.data = imageData
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
        }
    }
}

#Preview {
    RecognizerView()
}
