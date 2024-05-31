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
                        
                    } label: {
                        HStack(alignment: .center) {
                            Image("logo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 50)
                                .offset(x: -20)
                            Text("Neighborhood Guides")
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                                .frame(maxHeight: 100)
                                .offset(x: -20)
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
                            Image("logo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 50)
                                .offset(x: -20)
                            Text("Calendar Specific Restaurants")
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                                .frame(maxHeight: 100)
                                .offset(x: -20)
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
