import SwiftUI

struct FavoriteView: View {
    @ObservedObject var viewModel = FavoriteViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.businesses) { restaurant in
                        ZStack(alignment: .leading) {
                            NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                                    EmptyView()
                            }
                            .opacity(0.0)
                            RestaurantCellView(restaurant: restaurant)
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.deleteFavRestaurant(at: indexSet)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Favorite")
        }
    }
}


#Preview {
    FavoriteView()
}
