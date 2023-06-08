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
    @Binding var showModal: Bool
    @Binding var selectedName: String
    
    func makeUIView(context: Context) -> SCNView {
        sceneView.backgroundColor = .clear
        
        //MARK: default garden file
        sceneView.scene = createScene()
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.defaultCameraController.maximumVerticalAngle = 0.001
        
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
            
        if let landNode = loadSCNFile(named: "land") {
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
        
        for i in 0..<garden.count {
            guard let node = loadSCNFile(named: garden[i].fileName) else {
                return nil
            }
            node.position = SCNVector3(
                x: garden[i].positionX,
                y: garden[i].positionY,
                z: garden[i].positionZ
            )
            addNode.addChildNode(node)
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
        
        init(_ parent: GardenSceneView) {
            self.parent = parent
        }
        
        @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
            let location = gestureRecognizer.location(in: gestureRecognizer.view)
            let hitTestResults = parent.sceneView.hitTest(location, options: nil)
            
            if let hitNode = hitTestResults.first?.node {
                parent.showModal = true
                parent.selectedName = hitNode.geometry?.name ?? ""
            }
        }
    }
}
