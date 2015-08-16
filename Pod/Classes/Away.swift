import Foundation
import CoreLocation

public class Away {

    public class func buildLocation(distanceInMeters: Double, from: CLLocation, bearing: Double=90)-> CLLocation{
        var distanceInKm = (distanceInMeters / 1000.0)
        distanceInKm = distanceInKm / 6371.0
        var bearingRad = bearing.toRadians // Degrees to move to

        let baseLatitude = from.coordinate.latitude.toRadians
        let baseLongitude = from.coordinate.longitude.toRadians

        var resultLatitude = asin(sin(baseLatitude) * cos(distanceInKm) + cos(baseLatitude) * sin(distanceInKm) * cos(bearingRad))
        var resultLongitude = baseLongitude + atan2( sin(bearingRad) * sin(distanceInKm) * cos(baseLatitude),cos(distanceInKm) - sin(baseLatitude) * sin(resultLatitude));
        resultLatitude = resultLatitude.toDegrees
        resultLongitude = resultLongitude.toDegrees

        let newLocation = CLLocation(latitude: resultLatitude, longitude: resultLongitude)
        return newLocation
    }


    public class func buildTrip(distanceInMeters: NSNumber)-> [CLLocation]{
        let result : [CLLocation] = []
        return result
    }
}

public extension Double {
    var toRadians : Double {
         return self * M_PI / 180.0
    }

    var toDegrees : Double {
         return self * 180.0 / M_PI
    }

    var miles : Double {
        return self * 1600
    }

    var Km: Double {
        return self * 1000
    }
}
