import SwiftUI

struct HomeView: View {
    
    var body: some View {
                
        NavigationStack {
            VStack {
                List(){
                    ForEach(1..<5){ _ in
                        RestaurantCellView()
                            .listRowSeparator(.hidden)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle(Text("Top Recommendation"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
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
            .searchable(text: .constant(""))
            .onAppear()
            .padding(.top)
            .padding(.horizontal, -10)
        }
    }

}

#Preview {
    HomeView()
}
