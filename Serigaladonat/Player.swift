//
//  Player.swift
//  Serigaladonat
//
//  Created by David Gunawan on 09/06/20.
//  Copyright © 2020 David Gunawan. All rights reserved.
//

import SceneKit

class Player: SCNNode {
    
    private var wolf: Wolf?
    
    private let lookAtForwardPosition = SCNVector3Make(0.0, 0.0, 1.0)
    private let cameraForwardPosition = SCNVector3(x: 0,y: 1,z: -2)
    var basetAltitude: Float = 0
    
    private var lookAtNode: SCNNode?
    private var cameraNode: SCNNode?
    private var playerNode: SCNNode?
    
    override init() {
        super.init()
        
        // Wolf
        loadWolf()
        // Lighting
        loadLight()
        // Camera
        loadCameraFollow()
    }
    
    func loadWolf() {
        wolf = Wolf()
        addChildNode(wolf!)
    }
    
    func changeWolf(_ state: WolfState) {
        wolf?.setWolf(state: state)
    }
    
    func loadCameraFollow() {
        //LookAt Node
        lookAtNode = SCNNode()
        lookAtNode?.position = lookAtForwardPosition
        addChildNode(lookAtNode!)
        
        //Camera Node
        cameraNode = SCNNode()
        cameraNode?.camera = SCNCamera()
        cameraNode?.position = cameraForwardPosition
        cameraNode?.camera!.zNear = 0.1
        cameraNode?.camera!.zFar = 200
        addChildNode(cameraNode!)
    }
    
    func loadLight() {
        // Create a spotlight at the player
        let spotLight = SCNLight()
        spotLight.type = SCNLight.LightType.directional
        spotLight.spotInnerAngle = 40.0
        spotLight.spotOuterAngle = 80.0
        spotLight.castsShadow = true
        spotLight.color = UIColor.white
        let spotLightNode = SCNNode()
        spotLightNode.light = spotLight
        spotLightNode.position = SCNVector3(x: 1.0, y: 5.0, z: -2.0)
        self.addChildNode(spotLightNode)
        
        let constraint2 = SCNLookAtConstraint(target: self)
        constraint2.isGimbalLockEnabled = true
        spotLightNode.constraints = [constraint2]

        // Create additional omni light
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLight.LightType.omni
        lightNode.light!.color = UIColor.darkGray
        lightNode.position = SCNVector3(x: 0, y: 10.00, z: -2)
        self.addChildNode(lightNode)
    }
    
    public func updateWolfPosition(joyStickData: AnalogJoystickData, velocityMultiplier: CGFloat) {
        let xMovement = -joyStickData.velocity.x * velocityMultiplier
        let zMovement = (joyStickData.velocity.y * velocityMultiplier)

        self.position = SCNVector3(
            CGFloat(self.position.x) + xMovement,
            0,
            CGFloat(self.position.z) + zMovement)

        wolf?.eulerAngles.y = Float(joyStickData.angular)

        lookAtNode?.rotation = SCNVector4(
            Int((lookAtNode?.position.y)! + Float(joyStickData.angular)),
            Int((lookAtNode?.position.y)! + Float(joyStickData.angular)),
            Int((lookAtNode?.position.y)! + Float(joyStickData.angular)),0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
