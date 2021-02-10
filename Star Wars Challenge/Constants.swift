//
//  Constants.swift
//   Challenge
//
//  Created by Jack Higgins on 1/27/21.
//

import Foundation
import UIKit

class APIConfig {
    static let api = "https://swapi.dev/api"
}

enum SWCategories: String {
    case People = "People"
    case Films = "Films"
    case Starships = "Starships"
    case Vehicles = "Vehicles"
    case Planets = "Planets"
    case Species = "Species"
}

struct SWColors {
    static let lightGray = Utilities.sharedManager.hexStringToUIColor(hex: "f2f2f2")
    static let darkGray = Utilities.sharedManager.hexStringToUIColor(hex: "313131")
}

struct DeviceDimensions {
    static let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
}
