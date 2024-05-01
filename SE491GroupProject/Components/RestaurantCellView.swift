import SwiftUI

struct RestaurantCellView: View {
    var body: some View {
        VStack(spacing: 23) {
            Image("gyu_kaku")
                .resizable()
                .scaledToFill()
                .frame(height: 180)
            
            HStack() {
                VStack(alignment: .leading){
                    Text("Gyu Kaku")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    
                    Text("Japanese")
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
    RestaurantCellView()
}
