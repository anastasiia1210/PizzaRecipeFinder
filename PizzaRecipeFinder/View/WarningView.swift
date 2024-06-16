import SwiftUI

struct WarningView: View {
    var body: some View {
        VStack{
            Text("To recognize a pizza, please press the button located at the bottom of the screen to start the recognition process.")
                .font(.title2)
                .fontWeight(.semibold)
            Text("The app is capable of recognizing the following types of pizzas:")
                           .font(.title2)
                           .fontWeight(.semibold)
                           .padding(.top, 10)
            VStack(alignment: .leading, spacing: 5) {
                            Text("• Capricciosa")
                                .font(.title3)
                            Text("• Diavola")
                                .font(.title3)
                            Text("• Margherita")
                                .font(.title3)
                            Text("• Marinara")
                                .font(.title3)
                            Text("• Multiple")
                                .font(.title3)
                            Text("• Ortolana")
                                .font(.title3)
                            Text("• Other")
                                .font(.title3)
                            Text("• Quattro Formaggi")
                                .font(.title3)
            }
        }
    }
}

#Preview {
    WarningView()
}
