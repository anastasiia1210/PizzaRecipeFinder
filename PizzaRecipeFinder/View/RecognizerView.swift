import SwiftUI
import PhotosUI


struct RecognizerView: View {
    
    @StateObject private var recognizer = Recognizer()
    @State var selectedImage: PhotosPickerItem? = nil

    
    var body: some View {
        VStack{
            if let data = recognizer.data, let image = UIImage(data: data) {
                RecognitionResult(recognizer: recognizer, image: image)
            }else{
                WarningView()
            }
            Spacer()
            PhotosPicker(
                selection: $selectedImage,
                matching: .images,
                photoLibrary: .shared()){
                    Text("Розпізнати")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: 300)
                                        .background(Color.orange)
                                        .cornerRadius(10)
                }
                .onChange(of: selectedImage) { newItem in
                    Task {
                        if let imageData = try? await newItem?.loadTransferable(type: Data.self) {
                            recognizer.data = imageData
                            recognizer.classifier()
                        }
                    }
                    
                }
        }
        }
    
}
#Preview {
    RecognizerView()
}

