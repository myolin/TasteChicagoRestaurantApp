import SwiftUI

struct ListView: View {
    @State var title: String
    @StateObject var viewModel: ListViewModel
    
    var body: some View {
        VStack{
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
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .navigationTitle(title)
    }
}

#Preview {
    ListView(title: "American", viewModel: ListViewModel("American"))
}
