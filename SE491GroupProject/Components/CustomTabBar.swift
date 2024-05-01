import SwiftUI

enum Tab: String, CaseIterable {
    case home = "house"
    case category = "tablecells"
    case favorite = "heart.circle"
    case reservation = "calendar.circle"
    case profile = "person.circle"
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(tab == selectedTab ? 1.5 : 1.0)
                        .foregroundColor(selectedTab == tab ? .brown : .gray)
                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                        .offset(y: -10)
                    Spacer()
                }
            }
            .frame(width: nil, height: 70)
            .background(.thinMaterial)
            .cornerRadius(10)
        }
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.home))
}
