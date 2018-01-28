//
//  ViewController.swift
//  ARKit_Planets
//
//  Created by IJke Botman on 27/01/2018.
//  Copyright © 2018 IJke Botman. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let sun = SCNNode()
        let earthParent = SCNNode()
        let venusParent = SCNNode()
        let moonParent = SCNNode()
        
        sun.geometry = SCNSphere(radius: 0.35)
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun_Diffuse")
        sun.position = SCNVector3(0, 0, -1)
        
        earthParent.position = SCNVector3(0, 0, -1)
        venusParent.position = SCNVector3(0, 0, -1)
        moonParent.position = SCNVector3(1.2, 0, 0)
        
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth_day"), specular: #imageLiteral(resourceName: "Earth_Specular"), emission: #imageLiteral(resourceName: "Earth_Clouds"), normal: #imageLiteral(resourceName: "Earth_Normal"), position: SCNVector3(1.2, 0, 0))
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus_Diffuse"), specular: nil, emission: #imageLiteral(resourceName: "Venus_Atmosphere"), normal: nil, position: SCNVector3(0.7, 0, 0))
        let earthMoon = planet(geometry: SCNSphere(radius: 0.03), diffuse: #imageLiteral(resourceName: "Moon"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0.3, 0, 0))
        
        

        let sunAction = rotation(time: 8)
        let earthParentRotation = rotation(time: 14)
        let venusParentRotation = rotation(time: 20)
        let moonRotation = rotation(time: 5)
        let earthRotation = rotation(time: 10)
        let venusRotation = rotation(time: 20)
        
        sun.runAction(sunAction)
        earthParent.runAction(earthParentRotation)
        venusParent.runAction(venusParentRotation)
        earth.runAction(earthRotation)
        venus.runAction(venusRotation)
        moonParent.runAction(moonRotation)
        
        earth.addChildNode(earthMoon)
        earthParent.addChildNode(earth)
        earthParent.addChildNode(moonParent)
        moonParent.addChildNode(earthMoon)
        venusParent.addChildNode(venus)
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        
        return planet
    }
    
    func rotation(time: TimeInterval) -> SCNAction {
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(rotation)
        
        return foreverRotation

    }
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180}
}

