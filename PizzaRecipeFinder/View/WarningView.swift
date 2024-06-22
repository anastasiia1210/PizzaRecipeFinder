import SwiftUI

struct WarningView: View {
    var body: some View {
        VStack{
            Text("To recognize a pizza, select one of the available options. If you want to take a photo of the pizza, click Camera, if you want to select an existing photo, click Photo Library.")
                .font(.title3)
            Text("The app is capable of recognizing the following types of pizzas:")
                .font(.title3)
                .padding(.top, 10)
            VStack(alignment: .leading, spacing: 5) {
                Text("• Capricciosa")
                Text("• Diavola")
                Text("• Margherita")
                Text("• Marinara")
                Text("• Multiple")
                Text("• Ortolana")
                Text("• Other")
                Text("• Quattro Formaggi")
            }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                .padding()
            Spacer()
        }
    }
}

#Preview {
    WarningView()
}

