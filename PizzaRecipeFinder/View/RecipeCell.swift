import SwiftUI

struct RecipeCell: View {
    
    var recipe: Recipe
    
    var body: some View {
        VStack(spacing: -15) {
            AsyncImage(url: URL(string: recipe.imageUrl ?? "")) { phase in
                ZStack{
                    phase
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 220)
                        .clipped()
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(LinearGradient(gradient: Gradient(colors: [.clear, Color("CellBg")]), startPoint: .center, endPoint: .bottom))
                }
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading){
                HStack{
                    Text(recipe.name)
                        .font(.system(size: 26, weight: .bold, design: .default))
                    Spacer()
                    Button(action: {
                       // recipe.isLiked = true
                          }) {
                              Image(systemName: "heart")
                                  .imageScale(.large)
                              .foregroundColor(Color("Accent"))
                              .bold()
                          }
                }
                Text(recipe.description ?? "")
                    .lineLimit(2)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }.padding()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
        }
        .frame(maxWidth: 375)
        .frame(height: 300)
        .background(Color("CellBg"))
        .clipShape(RoundedRectangle(cornerRadius: 24.0))
        .shadow(radius: 8)
    }
}

#Preview {
    RecipeCell(recipe: Recipe.sampleRecipe)
}
