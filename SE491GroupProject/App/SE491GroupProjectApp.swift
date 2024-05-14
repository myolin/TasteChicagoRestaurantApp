import SwiftUI
import Firebase

@main
struct SE491GroupProjectApp: App {
    @StateObject var viewModel = AuthViewModel()
    @StateObject var globalSearch = GlobalSearch()
    @State private var showSplash = true
        
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashScreenView(showSplash: $showSplash)
                } else {
                    ContentView().environmentObject(viewModel)
                }
            }
            .environmentObject(globalSearch)
        }
    }
}
