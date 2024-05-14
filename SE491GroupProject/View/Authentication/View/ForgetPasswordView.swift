import SwiftUI

struct ForgetPasswordView: View {
    
    @State private var username: String = ""
    @State private var showingAlert = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            //logo
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: 200)
                .padding(.vertical, 32)
            
            // form fields
            VStack(spacing: 24) {
                InputView(text: $username,
                          title: "Email Address",
                          placeholder: "Enter the email associated with your account")
                .textInputAutocapitalization(.never)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            //forget password button
            Button {
                viewModel.forgetPassword(withEmail: username)
                showingAlert = true
            } label: {
                HStack {
                    Text("Forget Password")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 40)
            }
            .background(Color(.systemGreen))
            .cornerRadius(10)
            .padding(.top, 24)
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Password Reset Email Sent"),
                    message: Text("Please check your inbox"),
                    dismissButton: Alert.Button.default(
                        Text("Back To Login"),
                        action: { dismiss() }))

            }
            
            //navigate back to login view
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Remember your password?")
                    Text("Sign In")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
            .padding(.top, 12)
            
            Spacer()
        }
    }
}

#Preview {
    ForgetPasswordView()
}
