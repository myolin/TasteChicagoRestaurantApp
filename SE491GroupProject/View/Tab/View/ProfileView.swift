import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showingChangePasswordView = false
    @State private var showingRequestPage = false

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
            
            Section("General") {
                //version info
                HStack {
                    ProfileRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                    
                    Spacer()
                    
                    Text("1.0.0")
                        .font(.subheadline)
                        .foregroundColor(Color(.systemGray))
                }
                
                Button(action: {
                    showingRequestPage.toggle()
                }) {
                    ProfileRowView(imageName: "pencil.circle.fill", title: "Request a restaurant", tintColor: Color.purple)
                }
                .sheet(isPresented: $showingRequestPage) {
                    RequestRestaurantView()
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

struct RequestRestaurantView: View {
    @Environment(\.dismiss) var dismiss
    @State private var restaurantName = ""
    @State private var restaurantAddress = ""
    private var service = FirestoreService()
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Request a restaurant")
                .font(Font.custom("Futura", size: 25))
                .padding(.top, 25)
            VStack(spacing: 16) {
                InputView(text: $restaurantName,
                          title: "Restaurant Name",
                          placeholder: "")
                InputView(text: $restaurantAddress,
                          title: "Restaurant Address",
                          placeholder: "")
                Button {
                    service.makeRequest(name: restaurantName, address: restaurantAddress)
                    dismiss()
                } label: {
                    HStack {
                        Text("REQUEST")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 40)
                }
                .background(Color(.purple))
                .cornerRadius(10)
                .padding(.top, 24)
            }
            Spacer()
        }
        .padding()
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
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

