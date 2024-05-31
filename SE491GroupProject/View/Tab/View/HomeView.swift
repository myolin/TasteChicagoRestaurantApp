import SwiftUI

struct HomeView: View {
    @EnvironmentObject var globalSearch: GlobalSearch
    @StateObject var viewModel = HomeViewModel()
    @State private var searchTerm = ""
    @State private var showYelpSearch = false
    
    var body: some View {
                
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.restaurants) { restaurant in
                        ZStack(alignment: .leading) {
                            NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                                EmptyView()
                            }
                            .opacity(0.0)
                            RestaurantCellView(restaurant: restaurant)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationTitle(Text("Top Recommendation"))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        ProfileView()
                    } label: {
                        Image(systemName: "person.circle")
                            .scaleEffect(1.2)
                            .foregroundColor(.brown)
                            .font(.system(size: 20))
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showYelpSearch.toggle()
                    } label: {
                        HStack(spacing: 2) {
                            Text("Yelp")
                                .font(.system(size: 17))
                                .foregroundColor(.red)
                            Image(systemName: "magnifyingglass.circle")
                                .font(.system(size: 24))
                                .foregroundColor(.red)
                                .fontWeight(.semibold)
                        }
                    }
                }
            }
            .searchable(text: $searchTerm, prompt: "Search Restaurants") {
                ForEach(viewModel.filteredRestaurants) { restaurant in
                    ZStack(alignment: .leading) {
                        NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                            EmptyView()
                        }
                        .opacity(0.0)
                        RestaurantCellView(restaurant: restaurant)
                    }
                }
                .listRowSeparator(.hidden)
            }
            .onChange(of: searchTerm) {
                viewModel.filteredRestaurants = globalSearch.allRestaurants.filter({ restaurant in
                    restaurant.name.localizedCaseInsensitiveContains(searchTerm)
                })
            }
            .padding(.top)
            .padding(.horizontal, -10)
            .onAppear {
                viewModel.getTopRecommendation(globalSearch)
            }
            .sheet(isPresented: $showYelpSearch) {
                YelpSearchView()
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(GlobalSearch())
        .environmentObject(AuthViewModel())
}
