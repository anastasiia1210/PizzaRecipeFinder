import SwiftUI

struct RecognitionResult: View {
    
    @State var recognizer: Recognizer
    @State var image: UIImage
    @ObservedObject var recipeModel = RecipeModel.model
    
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
                            .font(.headline)
                        ForEach(mapIngridients(ingredients: recognizer.ingredients), id: \.self) { ingredient in
                            Text("· \(ingredient.name)")
                        }
                    } else{
                        Text("The object has no recipe:)")
                    }
                }
            }
            if((pizzaIDMapping[recognizer.identifier] ?? -1) != -1){
                VStack{
                    let recipeID = pizzaIDMapping[recognizer.identifier] ?? -1
                    if let recipeIndex = recipeModel.allRecipes.firstIndex(where: { $0.id == recipeID }) {
                        NavigationLink(destination: RecipeDetails(recipe: $recipeModel.allRecipes[recipeIndex])) {
                            Text("Recipe")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("Accent"))
                                .cornerRadius(10)
                        }
                    }
                    
                    
                    NavigationLink(destination: {
                        let recipe = generateRecipe(ingredients: recognizer.ingredients)
                        GeneratedRecipeDetails(recipe: recipe)
                    }){
                        Text("Generate Recipe")
                            .fontWeight(.bold)
                            .foregroundColor(Color("Accent"))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("Accent"), lineWidth: 2)
                            )
                    }
                }
                .frame(alignment: .bottom)
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
