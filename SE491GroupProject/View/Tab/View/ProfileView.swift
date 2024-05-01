import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        List {
            
            Section("Account") {
                
                //sign out button
                Button {
                    viewModel.signOut()
                } label: {
                    ProfileRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: Color(.red))
                }
            }
        }

    }
}

#Preview {
    ProfileView()
}
