import SwiftUI
import WebKit

struct RestaurantDetailView: View {
    var restaurant: Business
    @StateObject var viewModel = RestaurantDetailViewModel()
    @State private var showMenuWebView = false
    @State private var showYelpWebView = false
    @State private var showHours = false
    @State private var showMapView = false
    
    var body: some View {
        ScrollView {
            ZStack {
                Color.white
                
                VStack(alignment: .leading) {
                    ZStack(alignment: .topTrailing) {
                        AsyncImage(url: URL(string: restaurant.image_url)) { phase in
                            switch(phase) {
                            case .failure:
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: .infinity, maxHeight: 300)
                                    .clipped()
                            default:
                                ProgressView()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 300)
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(restaurant.name)
                                    .font(.title2.bold())
                                
                                HStack {
                                    Text(restaurant.categories)
                                        .font(.subheadline)
                                    Text(Image(systemName: "circle.fill"))
                                        .font(.system(size: 10))
                                        .foregroundStyle(Color.gray)
                                    Text(restaurant.price)
                                        .font(.subheadline)
                                    Text(Image(systemName: "circle.fill"))
                                        .font(.system(size: 10))
                                        .foregroundStyle(Color.gray)
                                    if viewModel.isOpenNow {
                                        Text("Open")
                                            .font(.headline)
                                            .foregroundStyle(Color.green)
                                    } else {
                                        Text("Closed")
                                            .font(.headline)
                                            .foregroundStyle(Color.red)
                                    }
                                }
                                
                                HStack {
                                    Text(Image(systemName: "location.circle.fill"))
                                        .foregroundStyle(Color.blue)
                                        .font(.system(size:20))
                                    VStack(alignment: .leading) {
                                        ForEach(restaurant.address.display_address, id: \.self){address in
                                            Text(address)
                                        }
                                    }
                                    .padding(.top, 20)
                                }
                                
                                
                                HStack {
                                    Text(Image(systemName: "phone.circle.fill"))
                                        .foregroundStyle(Color.green)
                                        .font(.system(size:20))
                                    Text(restaurant.phone)
                                }
                                .padding(.top, 8)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 25) {
                                Button {
                                    showMenuWebView.toggle()
                                } label: {
                                    HStack {
                                        Text("Menu")
                                        Text(Image(systemName: "menucard.fill"))
                                    }
                                    .frame(width: 100, height: 40)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 20))
                                    .foregroundStyle(Color.white)
                                    .background(Color.red)
                                    .cornerRadius(5)
                                }
                                .sheet(isPresented: $showMenuWebView) {
                                    WebView(url: URL(string: restaurant.menu.menu_url)!)
                                        .presentationDragIndicator(.visible)
                                }
                                
                                Button {
                                    showYelpWebView.toggle()
                                } label: {
                                    Image("yelp")
                                        .resizable()
                                        .frame(width: 70, height: 30)
                                }
                                .sheet(isPresented: $showYelpWebView) {
                                    WebView(url: URL(string: restaurant.yelp_url)!)
                                        .presentationDragIndicator(.visible)
                                }
                                
                                Button {
                                    viewModel.addToFav(restaurant)
                                } label: {
                                    Image(systemName: "heart.fill")
                                        .resizable()
                                        .foregroundStyle(Color.yellow)
                                        .frame(width: 25, height: 25)
                                }
                                
                                Spacer()
                            }
                        }
                        .padding(.vertical)
                        
                        HStack {
                            Spacer()
                            Button {
                                showHours = true
                            } label: {
                                HStack {
                                    Text(Image(systemName: "clock.fill"))
                                    Text("See hours")
                                }
                                .frame(width: 150, height: 40)
                                .foregroundStyle(Color.white)
                                .background(Color.primary)
                                .cornerRadius(10)
                            }
                            .sheet(isPresented: $showHours) {
                                VStack(alignment: .center, spacing: 20){
                                    Text("Opening Hours")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    let message = viewModel.getOpenHours(restaurant.hours)
                                    Text(message)
                                        .multilineTextAlignment(.center)
                                }
                                .presentationDetents([.height(280)])
                                .presentationDragIndicator(.visible)
                                .padding()
                            }
                            Spacer()
                            Button {
                                showMapView = true
                            } label: {
                                HStack {
                                    Text(Image(systemName: "map.fill"))
                                    Text("Map View")
                                }
                                .frame(width: 150, height: 40)
                                .foregroundStyle(Color.white)
                                .background(Color.primary)
                                .cornerRadius(10)
                            }
                            .sheet(isPresented: $showMapView) {
                                let location = MapLocation(name: restaurant.name, lattitude: restaurant.coordinates.latitude, longitude: restaurant.coordinates.longitude)
                                MapView(location: location)
                                    .presentationDragIndicator(.visible)
                            }
                            
                            Spacer()
                        }
                        
                        
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                    .offset(y: -30)
                }
            }
        }
        .ignoresSafeArea(edges: .top)
        .onAppear {
            viewModel.getIsOpenNow(restaurant.id)
        }
    }
}

struct WebView: UIViewRepresentable {
    let webView: WKWebView
    var webURL: URL
    
    init(url: URL) {
        webView = WKWebView(frame: .zero)
        webURL = url
    }
    
    func makeUIView(context: Context) -> some UIView {
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        webView.load(URLRequest(url: webURL))
    }
}

#Preview {
    RestaurantDetailView(restaurant: Business(id: "", alias: "", name: "Gyu Kaku", image_url: "", yelp_url: "", phone: "(223)561-9876", categories: "Japanese", coordinates: Coordinate(latitude: 0, longitude: 0), rating: 4.1, address: Address(display_address: ["235 Randolph St","Chicago, IL 60060"]), price: "$$", menu: Menu(menu_url: "http://www.minghincuisine.com/dimsum-menu"), hours: [Hour(hourOpen: [], isOpenNow: true)]))
}
