import SwiftUI
import TelemetryDeck

enum Tab: String, CaseIterable {
    case home = "house"
    case category = "tablecells"
    case favorite = "heart.circle"
    case reservation = "calendar.circle"
    case explore
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: selectedTab == Tab.home ? fillImage : Tab.home.rawValue)
                    .scaleEffect(Tab.home == selectedTab ? 1.5 : 1.0)
                    .foregroundColor(selectedTab == Tab.home ? .brown : .gray)
                    .font(.system(size: 22))
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)) {
                            selectedTab = Tab.home
                            TelemetryDeck.signal("ScreenVisited", parameters: ["screenName": "Home"])

                        }
                    }
                    .offset(y: -10)
                Spacer()
                Image(systemName: selectedTab == Tab.category ? fillImage : Tab.category.rawValue)
                    .scaleEffect(Tab.category == selectedTab ? 1.5 : 1.0)
                    .foregroundColor(selectedTab == Tab.category ? .brown : .gray)
                    .font(.system(size: 22))
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)) {
                            selectedTab = Tab.category
                            TelemetryDeck.signal("ScreenVisited", parameters: ["screenName": "Cuisine"])
                        }
                    }
                    .offset(y: -10)
                Spacer()
                Circle()
                    .fill(.gray)
                    .foregroundStyle(.white)
                    .frame(width: 80, height: 80)
                    .offset(y: -22)
                Spacer()
                Image(systemName: selectedTab == Tab.favorite ? fillImage : Tab.favorite.rawValue)
                    .scaleEffect(Tab.favorite == selectedTab ? 1.5 : 1.0)
                    .foregroundColor(selectedTab == Tab.favorite ? .brown : .gray)
                    .font(.system(size: 22))
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)) {
                            selectedTab = Tab.favorite
                            TelemetryDeck.signal("ScreenVisited", parameters: ["screenName": "Favorite Restaurants"])
                        }
                    }
                    .offset(y: -10)
                Spacer()
                Image(systemName: selectedTab == Tab.reservation ? fillImage : Tab.reservation.rawValue)
                    .scaleEffect(Tab.reservation == selectedTab ? 1.5 : 1.0)
                    .foregroundColor(selectedTab == Tab.reservation ? .brown : .gray)
                    .font(.system(size: 22))
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)) {
                            selectedTab = Tab.reservation
                            TelemetryDeck.signal("ScreenVisited", parameters: ["screenName": "Reservation"])
                        }
                    }
                    .offset(y: -10)
                Spacer()
                
            }
            .frame(width: nil, height: 70)
            .background(.thinMaterial)
            .cornerRadius(10)
            .overlay {
                ZStack {
                    Circle()
                        .fill(Tab.explore == selectedTab ? .brown : .white)
                        .foregroundStyle(.white)
                        .frame(width: 80, height: 80)
                        .shadow(radius: 4)
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .scaleEffect(Tab.explore == selectedTab ? 1.5: 1.0)
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = Tab.explore
                                TelemetryDeck.signal("FeatureUsed", parameters: ["featureName": "Explore Chicago"])
                                TelemetryDeck.signal("ScreenVisited", parameters: ["screenName": "Explore Chicago"])
                            }
                        }
                }
                .offset(x: 5, y: -22)
            }
        }
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.home))
}
