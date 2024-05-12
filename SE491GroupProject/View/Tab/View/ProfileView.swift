import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showingChangePasswordView = false

    var body: some View {
        List {
            Section(header: Text("User Info")) {
                HStack {
                    Text("Name: ")
                    Spacer()
                    Text(viewModel.currentUser?.fullname ?? "Unknown")
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }

                HStack {
                    Text("Email: ")
                    Spacer()
                    Text(viewModel.currentUser?.email ?? "No Email")
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            
            Section("Account Actions") {
                Button(action: {
                    viewModel.signOut()
                }) {
                    ProfileRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: Color.red)
                }

                Button(action: {
                    showingChangePasswordView = true
                }) {
                    ProfileRowView(imageName: "key.fill", title: "Forgot Password", tintColor: Color.blue)
                }
                .sheet(isPresented: $showingChangePasswordView) {
                    ForgetPasswordView().environmentObject(viewModel)
                }
                
                Button(action: {
                    viewModel.deleteAccount()
                }) {
                    ProfileRowView(imageName: "trash.fill", title: "Delete Account", tintColor: Color.red)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleUser = User(id: "1", fullname: "John Doe", email: "john@example.com")
        let authViewModel = AuthViewModel()
        authViewModel.currentUser = sampleUser
        return ProfileView().environmentObject(authViewModel)
    }
}

