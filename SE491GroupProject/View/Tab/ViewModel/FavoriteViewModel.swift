import Foundation

@MainActor
class FavoriteViewModel: ObservableObject {
    
    @Published var businesses = [Business]()
    
    let firestoreService = FirestoreService()
    
    init() {
        Task {
            await getUserFavRestaurant()
        }
    }
    
    // Get User Favorite Restaurant
    func getUserFavRestaurant() async {
        self.businesses = await firestoreService.getUserFavRestaurant()
    }
    
    // Delete User Favorite Restaurant
    func deleteFavRestaurant(at offsets: IndexSet) {
        let name = businesses[offsets[offsets.startIndex]].name
        businesses.remove(atOffsets: offsets)
        firestoreService.deleteUserFavRestaurant(name)
    }
}
