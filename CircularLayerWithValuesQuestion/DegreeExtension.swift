//
//  DegreeExtension.swift
//  Clubberize
//
//  Created by Reinier Melian on 1/25/17.
//  Copyright © 2017 David. All rights reserved.
//

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
    var radiansToDegrees: Double { return Double(self) * 180 / .pi }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
