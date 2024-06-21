import SwiftUI

struct RecognitionResult: View {
    
    @State var recognizer: Recognizer
    @State var image: UIImage
    @StateObject var recipeModel = RecipeModel()
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 10) {
                
                Image (uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .clipped()
                
                
                Text("\(recipeModel.getRecipeById(id: pizzaIDMapping[recognizer.identifier] ?? -1)?.name ?? "Other object") (\(String(format: "%.2f", recognizer.confidence*100))%)")
                    .foregroundColor(Color("Accent"))
                    .font(.system(size: 26, weight: .bold, design: .default))
                
                if((pizzaIDMapping[recognizer.identifier] ?? -1) != -1){
                    
                    Text("Recognized ingredients:\n- Tomatoes\n- Mozzarella\n- Fresh basil\n- Olive oil")
                    
                    Spacer()
                    
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
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("Accent"))
                        .cornerRadius(10)
                    
                }else{
                    
                    Text("Unfortuntelly, we are unable to find the recipe")
                    
                }
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .topLeading)
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}
#Preview {
    RecognitionResult(recognizer: Recognizer(), image: UIImage(systemName: "questionmark.circle")!)
}
