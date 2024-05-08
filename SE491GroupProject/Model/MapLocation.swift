import Foundation
import MapKit

struct MapLocation: Identifiable {
    let id = UUID()
    let name: String
    let lattitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lattitude, longitude: longitude)
    }
}
