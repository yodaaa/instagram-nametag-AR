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
import SafariServices

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
            let node = SCNNode()
            let imagePlaneNode = makeImagePlaneNode(imageAnchor: imageAnchor)
            let labelPlaneNode = makeLabelPlaneNode(imageAnchor: imageAnchor)
            imagePlaneNode.name = "nametest"
            labelPlaneNode.name = "labeltest"
            node.addChildNode(imagePlaneNode)
            node.addChildNode(labelPlaneNode)

            var textNode = SCNNode()
            textNode = makeLabelNode(text: "Daliちゃん")
            labelPlaneNode.addChildNode(textNode)
            return node
            
        case "my_photo_is_bad":
            DispatchQueue.main.async {
                
            }
            
            let node = SCNNode()
            let imagePlaneNode = makeImagePlaneNode(imageAnchor: imageAnchor)
            let labelPlaneNode = makeLabelPlaneNode(imageAnchor: imageAnchor)
            imagePlaneNode.name = "nametest"
            labelPlaneNode.name = "labeltest"
            node.addChildNode(imagePlaneNode)
            
            //下左
            let myImage8 = UIImage(named: "000037.jpg")
            if let validImage = myImage8 { //nilチェック
                let imageNode = makeImageNode(imageAnchor: imageAnchor, myImage: validImage)
                imageNode.position = SCNVector3(-imageAnchor.referenceImage.physicalSize.height, 0, imageAnchor.referenceImage.physicalSize.height * 3/3)
                node.addChildNode(imageNode)
            } else {
                fatalError()
            }
            
            //下真ん中
            let myImage1 = UIImage(named: "000028.jpg")
            if let validImage = myImage1 { //nilチェック
                let imageNode = makeImageNode(imageAnchor: imageAnchor, myImage: validImage)
                imageNode.position = SCNVector3(0, 0, imageAnchor.referenceImage.physicalSize.height * 3/3)
                node.addChildNode(imageNode)
            } else {
                fatalError()
            }
            
            //下右
            let myImage7 = UIImage(named: "000034.jpg")
            if let validImage = myImage7 { //nilチェック
                let imageNode = makeImageNode(imageAnchor: imageAnchor, myImage: validImage)
                imageNode.position = SCNVector3(imageAnchor.referenceImage.physicalSize.height, 0, imageAnchor.referenceImage.physicalSize.height * 3/3)
                node.addChildNode(imageNode)
            } else {
                fatalError()
            }
            
            // 中央左
            let myImage2 = UIImage(named: "000050.jpg")
            if let validImage = myImage2 { //nilチェック
                let imageNode = makeImageNode(imageAnchor: imageAnchor, myImage: validImage)
                imageNode.position = SCNVector3(-imageAnchor.referenceImage.physicalSize.height, 0, 0)
                node.addChildNode(imageNode)
            } else {
                fatalError()
            }
            
            //中央右
            let myImage3 = UIImage(named: "000014.jpg")
            if let validImage = myImage3 { //nilチェック
                let imageNode = makeImageNode(imageAnchor: imageAnchor, myImage: validImage)
                imageNode.position = SCNVector3(imageAnchor.referenceImage.physicalSize.height, 0, 0)
                node.addChildNode(imageNode)
            } else {
                fatalError()
            }
            
            //上右
            let myImage4 = UIImage(named: "000020.jpg")
            if let validImage = myImage4 { //nilチェック
                let imageNode = makeImageNode(imageAnchor: imageAnchor, myImage: validImage)
                imageNode.position = SCNVector3(imageAnchor.referenceImage.physicalSize.height, 0, -imageAnchor.referenceImage.physicalSize.height * 3/3)
                node.addChildNode(imageNode)
            } else {
                fatalError()
            }
            
            //上真ん中
            let myImage5 = UIImage(named: "000019.jpg")
            if let validImage = myImage5 { //nilチェック
                let imageNode = makeImageNode(imageAnchor: imageAnchor, myImage: validImage)
                imageNode.position = SCNVector3(0, 0, -imageAnchor.referenceImage.physicalSize.height * 3/3)
                node.addChildNode(imageNode)
            } else {
                fatalError()
            }
            
            //上左
            let myImage6 = UIImage(named: "000017.jpg")
            if let validImage = myImage6 { //nilチェック
                let imageNode = makeImageNode(imageAnchor: imageAnchor, myImage: validImage)
                imageNode.position = SCNVector3(-imageAnchor.referenceImage.physicalSize.height, 0, -imageAnchor.referenceImage.physicalSize.height * 3/3)
                node.addChildNode(imageNode)
            } else {
                fatalError()
            }
            return node
        default:
            return nil
        }
    }
    
    private func makeLabelNode(text: String) -> SCNNode {
        let depth: CGFloat = 0.001
        let font = UIFont(name: "HiraKakuProN-W3", size: 0.5);
        
        let textGeometory = SCNText(string: text, extrusionDepth: depth) //文字列とその厚み
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
    
    //画像表示するぞ
    private func makeImageNode(imageAnchor: ARImageAnchor, myImage: UIImage) -> SCNNode {
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height * 2/3)
        plane.firstMaterial?.diffuse.contents = myImage
        plane.firstMaterial?.transparency = 0.9
        let planeNode = SCNNode(geometry: plane)
        //planeNode.position = SCNVector3(0, 0, imageAnchor.referenceImage.physicalSize.height * 3/3)
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
            let safariVC = SFSafariViewController(url: URL(string: "https://www.instagram.com/__my_photo_is_bad__/?hl=ja")!)
            self.present(safariVC, animated: true, completion: nil)
            Logger.debugLog("nametest touched!")
        default:
            break
        }
    }
}
