//
//  Donut.swift
//  Serigaladonat
//
//  Created by octavianus on 09/06/20.
//  Copyright © 2020 David Gunawan. All rights reserved.
//

import SceneKit


class Donut: SCNNode{
    
    var particleEmitter: SCNNode!
    
    override init() {
        super.init()
        let donutScene = SCNScene(named: "art.scnassets/donut.scn")!
        
        let donutNode = donutScene.rootNode.childNode(withName: "donut", recursively: true)!
        donutNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        donutNode.physicsBody?.categoryBitMask = GameBitMask.donut
        
        
        let ringAction = SCNAction.rotateBy(x: 0, y: 0, z: CGFloat(GLKMathDegreesToRadians(360)), duration: 3)
        donutNode.runAction(SCNAction.repeatForever(ringAction))
        self.addChildNode(donutNode)
        
        particleEmitter = donutScene.rootNode.childNode(withName: "particleEmitter", recursively: true)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
