# Wheels-Up-Challenge

iOS App written in Swift that uses the SWAPI to fetch films, planets, vehicles, people, species, and starships. 
* Utilizes codable models to decode returned JSON.
* Alamofire 5 for networking layer.
* Built on Realm objects to store objects locally to reduce API calls.
* UI created programatically along with the use of XIBs.

### TODO
* UI error handling
* Loading indicators

## Installation

Use Cocoapods to install dependencies

```
pod install
```

## Libaries
    * Alamofire - Networking
    * Realm - Local database, caching
    * SwiftDate - Date parsing
