import SwiftUI

struct RecognitionResult: View {
    
    @State var recognizer: Recognizer
    @State var image: UIImage
    @StateObject var recipeModel = RecipeModel()
    
    var body: some View {
        VStack{
            ScrollView{
                VStack(alignment: .leading) {
                    
                    Image (uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .clipped()
                    
                    Text("\(recipeModel.getRecipeById(id: pizzaIDMapping[recognizer.identifier] ?? -1)?.name ?? "Other object") (\(String(format: "%.2f", recognizer.confidence*100))%)")
                        .foregroundColor(Color("Accent"))
                        .font(.system(size: 26, weight: .bold, design: .default))
                    
                    if((pizzaIDMapping[recognizer.identifier] ?? -1) != -1){
                        
                        Text("Recognized ingredients:")
                        ForEach(self.recognizer.ingredients, id: \.self) { ingredient in
                            Text("· \(ingredient)")
                        }
                    } else{
                        Text("The object has no recipe:)")
                    }
                }
            }
            if((pizzaIDMapping[recognizer.identifier] ?? -1) != -1){
                VStack{
                    NavigationLink(destination: {
                        let recipeID = pizzaIDMapping[recognizer.identifier] ?? -1
                        let recipe = recipeModel.getRecipeById(id: recipeID)
                        RecipeDetails(recipe: recipe!)
                    }) {
                        Text("Recipe")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("Accent"))
                            .cornerRadius(10)
                    }
                    
                    Text("Generate Recipe")
                        .fontWeight(.bold)
                        .foregroundColor(Color("Accent"))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("Accent"), lineWidth: 2)
                        )
                    
                    
                }.frame(alignment: .bottom)
            }
            
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .topLeading)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}
#Preview {
    RecognitionResult(recognizer: Recognizer(), image: UIImage(systemName: "questionmark.circle")!)
}
