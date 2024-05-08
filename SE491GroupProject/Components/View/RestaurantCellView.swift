import SwiftUI

struct RestaurantCellView: View {
    var restaurant: Business
    
    var body: some View {
        VStack(spacing: 23) {
            AsyncImage(url: URL(string: restaurant.image_url)) { phase in
                switch(phase) {
                case .failure:
                    Image(systemName: "photo")
                        .font(.largeTitle)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxHeight: 180)
                        .clipped()
                default:
                    ProgressView()
                }
            }
            .frame(maxHeight: 180)
            
            HStack() {
                VStack(alignment: .leading){
                    Text(restaurant.name)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    
                    Text(restaurant.categories)
                }
                .padding(.bottom, 10)
                Spacer()
                Text("⭐⭐⭐⭐⭐")
            }
            .padding(.horizontal)
        }
        .background(Color(.secondarySystemBackground))
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

#Preview {
    RestaurantCellView(restaurant: Business(id: "", alias: "", name: "Gyu Kaku", image_url: "", yelp_url: "", phone: "(223)561-9876", categories: "Japanese", coordinates: Coordinate(latitude: 0, longitude: 0), rating: 4.1, address: Address(display_address: ["235 Randolph St","Chicago, IL 60060"]), price: "$$", menu: Menu(menu_url: ""), hours: [Hour(hourOpen: [], isOpenNow: true)]))
}
