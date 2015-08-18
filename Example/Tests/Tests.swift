// https://github.com/Quick/Quick

import Quick
import Nimble
import CoreLocation
import Away

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("Away class methods") {
            let location = CLLocation(latitude: 11.008914, longitude: -74.810864)

            describe("buildLocation"){
                let distanceCases = [ 0.01, 1.0, 3.0, 9.0.Km, 99.99.Km, 0.1.Km, 1.miles ]

                it("contains a method called buildLocation that returns a CLLocation") {
                    expect(Away.buildLocation(3, from: location)).to(beAnInstanceOf(CLLocation))
                }

                it("receives a from parameter"){
                    expect(Away.buildLocation(3, from: location)).to(beAnInstanceOf(CLLocation))
                }

                it("returns a CLLocation that is N meters away from base location"){
                    for distance in distanceCases {
                        var resultLocation = Away.buildLocation(distance, from: location)
                        expect(resultLocation.distanceFromLocation(location)) >= distance
                    }
                }

                it("changes the latitude insignificantly if we dont pass the bearing degrees"){
                    for distance in distanceCases {
                        var resultLocation = Away.buildLocation(distance, from: location)
                        let difference = abs(resultLocation.coordinate.latitude - location.coordinate.latitude)
                        expect(difference) < 0.002
                    }
                }

                it("accepts an optional parameter for the bearing"){
                    for bearing in 0...360 {
                        var resultLocation = Away.buildLocation(100, from: location, bearing: Double(bearing))
                        var distanceDifference = resultLocation.distanceFromLocation(location) - 100
                        expect(distanceDifference) < 0.2
                    }
                }
            }

            describe("buildTrip"){
                let result = Away.buildTrip(3.Km, from: location, locations: 3)

                it("contains a method called buildTrip that returns CLLocation") {
                    expect(result[0]).to(equal(location))
                }


                it("distance between first and last location should be passed distance"){
                    let difference = location.distanceFromLocation(result.last!)
                    expect(difference) >= 3.Km
                }

                it("it should contain the same number of elements passed"){
                    expect(result.count).to(equal(3))
                }

                it("locations should be separated by the same distance [distance/locations]"){
                    let first = result.first!
                    let second = result[1]
                    let last  = result.last!

                    var firstDistance = second.distanceFromLocation(first)
                    var secondDistance = last.distanceFromLocation(second)
                    let difference = abs(firstDistance - secondDistance)

                    expect(difference) < 5
                }
            }
        }
    }
}
