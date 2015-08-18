import Foundation
import CoreLocation

public class Away {

    public class func buildLocation(distanceInMeters: Double, from: CLLocation, bearing: Double=90)-> CLLocation{
        var distanceInKm = (distanceInMeters / 1000.0)
        distanceInKm = distanceInKm / 6371.0
        var bearingRad = bearing.toRadians // Degrees to move to

        let baseLatitude = from.coordinate.latitude.toRadians
        let baseLongitude = from.coordinate.longitude.toRadians

        var resultLatitude = determineNewLatitude(baseLatitude, distanceInKm, bearingRad)
        var resultLongitude = determineNewLongitude(baseLatitude, baseLongitude, resultLatitude, bearingRad, distanceInKm)
        resultLatitude = resultLatitude.toDegrees
        resultLongitude = resultLongitude.toDegrees

        let newLocation = CLLocation(latitude: resultLatitude, longitude: resultLongitude)
        return newLocation
    }

    public class func buildTrip(distanceInMeters: Double, from: CLLocation, locations: Int=3)-> [CLLocation]{
        if locations < 2 {
            NSException(name:"InvalidArgument", reason:"Locations number should be greater than 1.", userInfo:nil).raise()
        }

        var result : [CLLocation] = [from]
        let distanceBetweenLocations = distanceInMeters / Double(locations-1)

        for index in (1...locations-1) {
            let location = buildLocation(distanceBetweenLocations, from: result.last!)
            result.append(location)
        }
        return result
    }

    class func determineNewLatitude( baseLatitude : Double,_ distanceInKm : Double,_ bearingRad: Double) -> Double {
        return asin(sin(baseLatitude) * cos(distanceInKm) + cos(baseLatitude) * sin(distanceInKm) * cos(bearingRad))
    }

    class func determineNewLongitude( baseLatitude: Double,_ baseLongitude : Double, _ resultLatitude: Double, _ bearingRad: Double,_ distanceInKm: Double )-> Double {
        return baseLongitude + atan2( sin(bearingRad) * sin(distanceInKm) * cos(baseLatitude),cos(distanceInKm) - sin(baseLatitude) * sin(resultLatitude));
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
