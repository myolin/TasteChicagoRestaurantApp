import SwiftUI

struct CalendarSpecificView: View {
    @StateObject private var viewModel = CalendarSpecificViewModel()
    @State private var title = "Choose an event"
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        Button {
                            viewModel.getData(category: "Valentines")
                            title = "Valentine Day"
                        } label: {
                            Image("valentine_day")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                        Button {
                            title = "New Year Day"
                        } label: {
                            Image("new_year_day")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                        Button {
                            title = "Christmas Day"
                        } label: {
                            Image("christmas_day")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .padding()
                }
                .scrollIndicators(.hidden)
                
                Text(title)
                    .fontWeight(.bold)
                    .font(.title2)
                
                ScrollView {
                    VStack {
                        ForEach(viewModel.restaurants) { restaurant in
                            ZStack(alignment: .leading) {
                                NavigationLink {
                                    RestaurantDetailView(restaurant: restaurant)
                                } label: {
                                    RestaurantCellView(restaurant: restaurant)
                                        .foregroundStyle(Color.black)
                                }
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .padding()
                }
                .listStyle(.plain)
                
                Spacer()
            }
            .navigationTitle("Calendar Events")
        }
    }
}

#Preview {
    CalendarSpecificView()
}
