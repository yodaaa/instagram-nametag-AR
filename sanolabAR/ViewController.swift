//
//  ViewController.swift
//  sanolabAR
//
//  Created by yodaaa on 2019/03/04.
//  Copyright © 2019 yodaaa. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var sceneView: ARSCNView!
    let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        //sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        configuration.trackingImages = referenceImages!
        configuration.maximumNumberOfTrackedImages = 1
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let imageAnchor = anchor as? ARImageAnchor else {
            return nil
        }
        
        //画像(マーカー)ごとに処理を分岐
        switch imageAnchor.referenceImage.name {
        case "Dali":
            DispatchQueue.main.async {
                
            }
            
            let node = SCNNode()
            let imagePlaneNode = makeImagePlaneNode(imageAnchor: imageAnchor)
            let labelPlaneNode = makeLabelPlaneNode(imageAnchor: imageAnchor)
            imagePlaneNode.name = "nametest"
            labelPlaneNode.name = "labeltest"
            node.addChildNode(imagePlaneNode)
            node.addChildNode(labelPlaneNode)
            var textNode = SCNNode()
            textNode = makeLabelNode(text: "aaaa")
            labelPlaneNode.addChildNode(textNode)
            return node
        default:
            return nil
        }
    }
    
    private func makeLabelNode(text: String) -> SCNNode {
        let depth: CGFloat = 0.001
        let font = UIFont(name: "HiraKakuProN-W3", size: 0.5);
        
        let textGeometory = SCNText(string: text, extrusionDepth: depth)
        textGeometory.flatness = 0
        textGeometory.font = font
        let textNode = SCNNode(geometry: textGeometory)
        let (min, max) = (textNode.boundingBox)
        let x = CGFloat(max.x - min.x)
        textNode.position = SCNVector3(-(x/2), -1, 0.1)
        
        return textNode
    }
    
    private func makeImagePlaneNode(imageAnchor: ARImageAnchor) -> SCNNode {
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
        plane.firstMaterial?.diffuse.contents = UIColor.black
        plane.firstMaterial?.transparency = 0.5
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -.pi / 2
        return planeNode
    }
    
    private func makeLabelPlaneNode(imageAnchor: ARImageAnchor) -> SCNNode {
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height / 3)
        plane.firstMaterial?.diffuse.contents = UIColor.black
        plane.firstMaterial?.transparency = 0.9
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3(0, 0, imageAnchor.referenceImage.physicalSize.height * 2 / 3)
        planeNode.eulerAngles.x = -.pi / 2
        return planeNode
    }
    
    // Nodeのタッチ判別と処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: sceneView),
            let result = sceneView.hitTest(location, options: nil).first else {
                return
        }
        let node = result.node
    
        switch node.name {
        case "labeltest":
            Logger.debugLog("labeltest touched!")
        case "nametest":
            Logger.debugLog("nametest touched!")
        default:
            break
        }
    }
}
