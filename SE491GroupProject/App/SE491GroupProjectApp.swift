import SwiftUI
import Firebase

@main
struct SE491GroupProjectApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    @State private var showSplash = true
        
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashScreenView()
                        .transition(.opacity)
                } else {
                    ContentView().environmentObject(viewModel)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        self.showSplash = false
                    }
                }
            }
        }
    }
}
