import SwiftUI

struct RecognitionResult: View {
    var recognizer: Recognizer
    var image: UIImage
    
    var body: some View {
        VStack{
            Image (uiImage: image)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 300)
            
            Text("Result of recognition: \(recognizer.identifier) - \(String(format: "%.2f", recognizer.confidence*100))%")
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 5){
                Text("Review the \(recognizer.identifier) recipe")
                Text("Here is the list of recognized ingredients: Tomatoes, Mozzarella, Fresh basil, Olive oil")
                Text("Generate your own recipe based on these products")
            }
        }
    }
}

//#Preview {
//    RecognitionResult()
//}
