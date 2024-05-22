import SwiftUI

struct YelpSearchView: View {
    @StateObject private var viewModel = YelpSearchViewModel()
    @State private var searchTerm = ""
    @State private var isEditing = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image("yelp_icon")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text("Yelp Search")
                        .font(Font.custom("American Typewriter", size: 25))
                        .fontWeight(.bold)
                }
                .padding(.top, 16)
                HStack {
                    TextField("Search ...", text: $searchTerm)
                        .autocorrectionDisabled()
                        .padding(7)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                            if isEditing {
                                Button {
                                    withAnimation {
                                        isEditing = false
                                    }
                                    searchTerm = ""
                                } label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundStyle(.gray)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        .onTapGesture {
                            withAnimation {
                                isEditing = true
                            }
                        }
                    
                    if isEditing {
                        Button {
                            isEditing = false
                            viewModel.search(searchTerm: searchTerm)
                            searchTerm = ""
                        } label: {
                            Text("Search")
                                .foregroundStyle(Color.white)
                                .fontWeight(.semibold)
                        }
                        .padding(7)
                        .background(Color.red)
                        .cornerRadius(8)
                        .padding(.trailing, 16)
                        .transition(.move(edge: .trailing))
                        .animation(.spring(), value: isEditing)
                    }
                }
                VStack {
                    List {
                        ForEach(viewModel.searchResults) { result in
                            ZStack {
                                HStack {
                                    NavigationLink(destination: WebView(url: URL(string:result.yelp_url)!)) {
                                        EmptyView()
                                    }
                                }
                                .opacity(0)
                                HStack {
                                    Text(result.name)
                                    Spacer()
                                    let distance = result.distance * 0.00062137
                                    let formatted = String(format: "%.1f", distance)
                                    Text("\(formatted) mi")
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    YelpSearchView()
}
