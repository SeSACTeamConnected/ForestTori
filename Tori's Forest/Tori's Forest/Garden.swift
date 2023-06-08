//
//  Garden.swift
//  Tori's Forest
//
//  Created by hyebin on 2023/06/08.
//

import Foundation

struct Garden {
    var fileName: String
    var positionX: Float
    var positionY: Float
    var positionZ: Float
}

class GardenObject: ObservableObject {
    @Published var garden = [Garden]()
    
    init() {
        garden.append(
            Garden(
                fileName: "Tree_small_bare",
                positionX: 0.2,
                positionY: 0,
                positionZ: 0
            )
        )
    }
}
