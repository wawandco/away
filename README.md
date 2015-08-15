# Away

[![CI Status](http://img.shields.io/travis/Antonio Pagano/Away.svg?style=flat)](https://travis-ci.org/Antonio Pagano/away)
[![Version](https://img.shields.io/cocoapods/v/Away.svg?style=flat)](http://cocoapods.org/pods/)
[![License](https://img.shields.io/cocoapods/l/Away.svg?style=flat)](http://cocoapods.org/pods/)
[![Platform](https://img.shields.io/cocoapods/p/Away.svg?style=flat)](http://cocoapods.org/pods/)

## About

Away is a library to generate CLLocations with distance constraints, we build this pod while developing an application that uses core location library and needed to unit-test some features.

At that point we didn't encounter something that would provide fake locations with distance constaints, so we decide to start working in Away while developing our app.

## Usage

There are 2 main functions inside Away: `buildLocation` and `buildTrip`

### buildLocation

Build location propose is to generate a single location that is some distance away from a `from` base location.

```Swift
  Away.buildLocation(3.miles(), from: baseLocation)
  Away.buildLocation(3.kilometers(), from: baseLocation)
```

It returns a CLLocation.

### buildTrip

Build Trip builds a sequence of locations that end some distance away from the

```Swift
  Away.buildTrip(3.miles(), locations: 3, from: baseLocation)
  Away.buildTrip(3.kilometers(), locations: 2, from: baseLocation)
```

It returns an array of CLLocations


## Requirements

## Installation

 is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "away"
```

## Author

Antonio Pagano, apagano@wawand.co

## License

 is available under the MIT license. See the LICENSE file for more info.
