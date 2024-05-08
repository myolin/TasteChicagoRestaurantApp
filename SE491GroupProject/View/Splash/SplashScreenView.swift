import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            Text("Welcome")
                .font(.title)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    SplashScreenView()
}
