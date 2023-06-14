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
                fileName: "STR_3D_dandelion_garden_animation",
                positionX: -1,
                positionY: 0.2,
                positionZ: 1
            )
        )
        
        garden.append(
            Garden(fileName: "STR_3D_cactus_garden_animation",
                   positionX: 1,
                   positionY: 0.2,
                   positionZ: -1)
        )
        
        garden.append(
            Garden(fileName: "STR_3D_maple_garden_animation",
                   positionX: 1,
                   positionY: 0.2,
                   positionZ: 1)
        )
        
        garden.append(
            Garden(fileName: "STR_3D_cotton_garden_animation",
                   positionX: -1,
                   positionY: 0.2,
                   positionZ: -1)
        )
        
    }
}
