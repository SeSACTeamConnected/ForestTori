//
//  GardenSceneView.swift
//  Tori's Forest
//
//  Created by hyebin on 2023/06/08.
//

import SwiftUI
import SceneKit

struct GardenSceneView: UIViewRepresentable {
    let sceneView = SCNView()
    
    @EnvironmentObject var gardenObject: GardenObject
    
    @FetchRequest(sortDescriptors: [])
    var plants: FetchedResults<Plant>
    
//    @FetchRequest(sortDescriptors: [])
//    var missions: FetchedResults<Mission>
    
    @Binding var chapterIndex: Int
    @Binding var isShowPlantHistoryView: Bool
    @Binding var selectedName: String
    
    func makeUIView(context: Context) -> SCNView {
        sceneView.backgroundColor = .clear
        
        //MARK: default garden file
        sceneView.scene = createScene()
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.defaultCameraController.maximumVerticalAngle = 30
        
        for gestureRecognizer in sceneView.gestureRecognizers ?? [] {
            if !(gestureRecognizer is UIPanGestureRecognizer) {
                gestureRecognizer.isEnabled = false
            }
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleTap(_:))
        )
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        
        return sceneView
    }
    
    func updateUIView(_ scnView: SCNView, context: Context) {
    }
    
    func createScene() -> SCNScene {
        let scene = SCNScene()
        let garden = gardenObject.garden
            
        if let landNode = loadSCNFile(named: "STR_3D_gardenground") {
            print(chapterIndex)
            landNode.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
            scene.rootNode.addChildNode(landNode)
        }
        
        if garden.count > 0 {
            let newNode = addNodeToScene()
            scene.rootNode.addChildNode(newNode!)
        }
        
        return scene
    }
    
    func addNodeToScene() -> SCNNode? {
        let addNode = SCNNode()
        let garden = gardenObject.garden
        
        for i in 0..<min(chapterIndex, 4) {
            guard let node = loadSCNFile(named: garden[i].fileName) else {
                return nil
            }
            
            node.position = SCNVector3(
                x: garden[i].positionX,
                y: garden[i].positionY,
                z: garden[i].positionZ
            )
            
            node.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
            
            addNode.addChildNode(node)
        }
        
        if chapterIndex < 4 {
            let bubble = loadSCNFile(named: "STR_3D_bubble")!
            
            bubble.position = SCNVector3(
                x: -garden[chapterIndex].positionX,
                y: garden[chapterIndex].positionY + 1.5,
                z: -garden[chapterIndex].positionZ
                )
            
            bubble.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
            
            addNode.addChildNode(bubble)
        }
        
        return addNode
    }
    
    
    func loadSCNFile(named name: String) -> SCNNode? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "scn") else {
            print("Failed to find SCN file: \(name).scn")
            return nil
        }
            
        do {
            let scene = try SCNScene(url: url, options: nil)
            
            let node = SCNNode()
            for childNode in scene.rootNode.childNodes {
                node.addChildNode(childNode)
            }
                
            return node
        } catch {
            print("Failed to load SCN file: \(error)")
            return nil
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    class Coordinator: NSObject {
        let parent: GardenSceneView
        let objectNames: Array<String> = ["dandelion", "cactus", "maple", "cottontree"]
        
        init(_ parent: GardenSceneView) {
            self.parent = parent
        }
        
        @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
            let location = gestureRecognizer.location(in: gestureRecognizer.view)
            let hitTestResults = parent.sceneView.hitTest(location, options: nil)
            
            if let hitNode = hitTestResults.first?.node {
                if let selectedName = hitNode.geometry?.name {
                    if objectNames.contains(selectedName) {
                        parent.isShowPlantHistoryView = true
                        parent.selectedName = selectedName
                        
                        print("\(parent.selectedName) is selected")
                    }
                }
//                parent.isShowPlantHistoryView = true
//                parent.selectedName = hitNode.geometry?.name ?? ""
            }
        }
    }
}
