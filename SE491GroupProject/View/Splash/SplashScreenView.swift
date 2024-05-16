import SwiftUI

struct SplashScreenView: View {
    @Binding var showSplash: Bool
    
    @State private var scale = CGSize(width: 0.8, height: 0.8)
    @State private var opacity = 1.0
    
    var body: some View {
        ZStack {
            Color.brown.ignoresSafeArea()
            
            ZStack {
                 Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                 
            }
            .scaleEffect(scale)
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5)) {
                scale = CGSize(width: 1, height: 1)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                withAnimation(.easeIn(duration: 0.35)) {
                    scale = CGSize(width: 50, height: 50)
                    opacity = 0
                }
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: {
                withAnimation(.easeIn(duration: 0.35)) {
                    showSplash.toggle()
                }
            })
        }
    }
}

#Preview {
    SplashScreenView(showSplash: .constant(true))
}
