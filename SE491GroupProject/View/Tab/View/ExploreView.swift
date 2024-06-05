import SwiftUI

struct ExploreView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Explore Chicago")
                    .font(Font.custom("Futura", size: 35))
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                VStack {
                    NavigationLink {
                        NeighborhoodGuidesView()
                    } label: {
                        HStack(alignment: .center) {
                            Image("neighborhood_guides")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 40)
                            Text("Neighborhood Guides")
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                                .frame(maxHeight: 100)
                            Spacer()
                        }
                    }
                }
                .background(.cyan)
                .cornerRadius(20)
                .padding()
                VStack {
                    NavigationLink {
                        
                    } label: {
                        HStack(alignment: .center) {
                            Image("calendar_specific")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 110, height: 40)
                                .offset(x: 20)
                            Text("Calendar Specific Restaurants")
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                                .frame(maxHeight: 100)
                                .offset(x: 30)
                            Spacer()
                        }
                    }
                }
                .background(.cyan)
                .cornerRadius(20)
                .padding()
                Spacer()
            }
        }
    }
}

#Preview {
    ExploreView()
}
