import Foundation
import TelemetryDeck
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }
    
    // Sign In
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
            // Signal if Sign In is Successful
            TelemetryDeck.signal("SignInSuccess")
        } catch {
            // Signal if Sign In is NOT Successful
            TelemetryDeck.signal("SignInFailure")
            print("DEBUG: Failed to sign in user with error \(error.localizedDescription)")
        }
    }
    
    // Sign Up
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
            
            // Signal for new account creations
            TelemetryDeck.signal("AccountCreated")
        } catch {
            // Signal for when new accounts are not created succesfully
            TelemetryDeck.signal("AccountCreationFailed")
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    // Sign Out
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            
            // Signal to track SignOuts
            TelemetryDeck.signal("SignOut")
        } catch {
            print("DEBUG: Failed to sing out with error \(error.localizedDescription)")
        }
    }
    
    // Forget Password
    func forgetPassword(withEmail email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("DEBUG: Failed to send a password reset email with error \(error.localizedDescription)")
            } else {
                // Signal to track Password Reset Requests
                TelemetryDeck.signal("PasswordResetRequested")
            }
        }
    }
    
    // Delete Account
    func deleteAccount() {
        guard let user = Auth.auth().currentUser else { return }
        user.delete() { error in
            if let error = error {
                print("DEBUG: Failed to delete user with error \(error.localizedDescription)")
            } else {
                self.userSession = nil
                self.currentUser = nil
                
                // Signal to track Account Deletions
                TelemetryDeck.signal("AccountDeleted")
            }
        }
    }
    
    // Get Current User
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
}
