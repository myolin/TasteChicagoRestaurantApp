import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.dismiss) var dismiss
    @State var location: MapLocation
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Map (initialPosition: .region(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))))
            {
                Marker(location.name, coordinate: location.coordinate)
            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
            }
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "x.circle")
                    .resizable()
                    .foregroundStyle(Color.black)
                    .frame(width: 50, height: 50)
                    .padding(.leading, 16)
                    .padding(.top, 16)
            }
        }
    }
}

#Preview {
    MapView(location: MapLocation(name: "The Dearbon", lattitude: 41.8842528, longitude: -87.6293151))
}
